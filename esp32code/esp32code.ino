#ifdef __cplusplus
extern "C" {
#endif
uint8_t temprature_sens_read();
#ifdef __cplusplus
}
#endif
uint8_t temprature_sens_read();

#include <WiFi.h>
#include "time.h"
#include <FirebaseESP32.h>
#include <Servo_ESP32.h>

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

static const int servoPin = 13;
Servo_ESP32 servo1;
bool servo_status;


int LED_BUILTIN = 2;
float temperature;
String scheduled_time;
String rgb;
char current_time[12];
const char* ntpServer = "pool.ntp.org";
const long  gmtOffset_sec = 19800;
const int   daylightOffset_sec = 0;
bool timestatus = true;
int servo_delay=500;

void setup()
{
  pinMode (LED_BUILTIN, OUTPUT);
  Serial.begin(115200);

  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.print("Connecting to Wi-Fi");
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print(".");
    delay(300);
  }
  Serial.println();
  Serial.print("Connected with IP: ");
  Serial.println(WiFi.localIP());
  Serial.println();

  Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

  /* Assign the api key (required) */
  config.api_key = API_KEY;

  /* Assign the user sign in credentials */
  auth.user.email = USER_EMAIL;
  auth.user.password = USER_PASSWORD;

  /* Assign the RTDB URL (required) */
  config.database_url = DATABASE_URL;

  /* Assign the callback function for the long running token generation task */
  config.token_status_callback = tokenStatusCallback; // see addons/TokenHelper.h


  Firebase.begin(&config, &auth);

  // Comment or pass false value when WiFi reconnection will control by your code or third party library
  Firebase.reconnectWiFi(true);

  Firebase.setDoubleDigits(5);
  configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);
  printLocalTime();

}

void loop()
{
 Firebase.RTDB.getBool(&fbdo,F("/devices/servo_status"),&servo_status);
 Firebase.RTDB.getInt(&fbdo,F("/devices/servo_delay"),&servo_delay);
  if(servo_status==true){
    Serial.println("Feeded now");
    digitalWrite(LED_BUILTIN, HIGH);
    spinservo(servo_delay);
    servo_status=false;
    Firebase.RTDB.setBool(&fbdo, "devices/servo_status", servo_status);
    digitalWrite(LED_BUILTIN, LOW);
    }
    Firebase.RTDB.getString(&fbdo, F("/devices/scheduled_time"),&scheduled_time);
 Serial.print("scheduled_time : ");
 Serial.println(scheduled_time);

 Firebase.RTDB.getString(&fbdo, F("/devices/rgb"),&rgb);
 Serial.print("RGB : ");
 Serial.println(rgb);
 
    printLocalTime();
 
  temperature =(temprature_sens_read() - 32) / 1.8;
  Firebase.RTDB.setFloat(&fbdo, "devices/temperature", temperature);
 
}








void printLocalTime(){
  struct tm timeinfo;
  if(!getLocalTime(&timeinfo)){
    Serial.println("Failed to obtain time");
    return;
  }
  Serial.print("Current_time : ");
  Serial.println(&timeinfo, "%I:%M %p");
  strftime(current_time,12, "%I:%M %p", &timeinfo);
  
  if(scheduled_time==current_time){
    if(timestatus==1){
    Serial.println("Feeded on time");
    digitalWrite(LED_BUILTIN, HIGH);
    spinservo(servo_delay);
    servo_status=false;
    Firebase.RTDB.setBool(&fbdo, "devices/servo_status", servo_status);
    digitalWrite(LED_BUILTIN, LOW);
    timestatus=0;
  }
  }
  else{
    Serial.println("Not_Feeded");
    timestatus=1;
  }
  Serial.println("");
}




void spinservo(int sdelay){
    servo1.attach(servoPin);
    servo1.write(50);
    delay(sdelay);
    servo1.detach();
    servo_status=false;
  }

  
