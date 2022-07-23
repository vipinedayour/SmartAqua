#include <WiFi.h>
#include <WiFiManager.h> 
#include "time.h"
#include <FirebaseESP32.h>
#include <ArduinoJson.h>
#include <Servo_ESP32.h>
#include <FastLED.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#define NUM_LEDS  60
#define LED_PIN  12
static const int servoPin = 13;
#define PIN_ANALOG_IN   34
const int oneWireBus = 25; // GPIO where the DS18B20 is connected to
 
#define TdsSensorPin 35
#define VREF 3.3      // analog reference voltage(Volt) of the ADC
#define SCOUNT  30           // sum of sample point 
int analogBuffer[SCOUNT];    // store the analog value in the array, read from ADC
int analogBufferTemp[SCOUNT];
int analogBufferIndex = 0;
int copyIndex = 0;
float averageVoltage = 0;
float tdsValue = 0;
float temperature = 0;
OneWire oneWire(oneWireBus);    // Setup a oneWire instance to communicate with any OneWire devices
 
DallasTemperature sensors(&oneWire);    // Pass our oneWire reference to Dallas Temperature sensor
 


// Provide the token generation process info.
#include <addons/TokenHelper.h>

// Provide the RTDB payload printing info and other helper functions.
#include <addons/RTDBHelper.h>

/* 1. Define the WiFi credentials */

// For the following credentials, see examples/Authentications/SignInAsUser/EmailPassword/EmailPassword.ino

/* 2. Define the API Key */
#define API_KEY "AIzaSyCJvb9vmHt-P3WoY2_W23OIicaXpUL7lHA"

/* 3. Define the RTDB URL */
#define DATABASE_URL "miniproject-8021b-default-rtdb.firebaseio.com" //<databaseName>.firebaseio.com or <databaseName>.<region>.firebasedatabase.app

/* 4. Define the user Email and password that alreadey registerd or added in your project */
#define USER_EMAIL "notsharks@gmail.com"
#define USER_PASSWORD "wearesharks"

// Define Firebase Data object
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;
CRGB leds[NUM_LEDS];
Servo_ESP32 servo1;


int LED_BUILTIN = 2;
char current_time[12];
const char* ntpServer = "pool.ntp.org";
const long  gmtOffset_sec = 19800;
const int   daylightOffset_sec = 0;
bool timestatus = true;
double tempC;
bool led_status;
String rgb; 
String led_animation;
String scheduled_time ; 
int servo_delay; 
bool servo_status;
int top_level;
int bottom_level;
TaskHandle_t Task1;

const int trigPin = 15;
const int echoPin = 4;
const int relay1 =26;
const int relay2=27;
#define SOUND_SPEED 0.034
long duration;
bool refill;
bool bringitdown=false;
float checkdist;
float distance_cm;
float filterArray[20]; // array to store data samples from sensor
float dist;
