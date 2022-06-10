#include <WiFi.h>
#include "time.h"
#include <FirebaseESP32.h>
#include <ArduinoJson.h>
#include <Servo_ESP32.h>
#include <FastLED.h>
#define NUM_LEDS  60
#define LED_PIN  12
static const int servoPin = 13;
#define PIN_ANALOG_IN   34


// Provide the token generation process info.
#include <addons/TokenHelper.h>

// Provide the RTDB payload printing info and other helper functions.
#include <addons/RTDBHelper.h>

/* 1. Define the WiFi credentials */
#define WIFI_SSID "EDAYOURWIFI"
#define WIFI_PASSWORD "Edayour8427"

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
TaskHandle_t Task1;
