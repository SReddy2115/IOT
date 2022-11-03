
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <MPU6050_light.h>

#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 64 // OLED display height, in pixels

Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire);


MPU6050 mpu(Wire);
unsigned long timer = 0;

void setup() {
  Serial.begin(115200);                               
  if(!display.begin(SSD1306_SWITCHCAPVCC, 0x3C))  
  { 
    Serial.println(F("SSD1306 allocation failed"));
    for(;;);                                     
  } 
  display.setTextSize(1);             
  display.setTextColor(SSD1306_WHITE);           
  display.clearDisplay();                         
  Wire.begin();
  mpu.begin();
  display.println(F("Calculating gyro offset, do not move MPU6050"));
  display.display();        
  mpu.calcGyroOffsets();                         
  display.setTextSize(2);          
}

void loop() {
  mpu.update();  
  if((millis()-timer)>10)                     
  {                                           
    display.clearDisplay();                  
    display.setCursor(0,0);                         
    display.print("P : ");
    display.println(mpu.getAngleX());
    display.print("R : ");
    display.println(mpu.getAngleY());
    display.print("Y : ");
    display.print(mpu.getAngleZ());
    display.display();                           
    timer = millis();  
  }
}
