void getData(){
Firebase.get(fbdo, F("/"));
const char * input = fbdo.to<const char *>();
  StaticJsonDocument<512> doc;

DeserializationError error = deserializeJson(doc, input);

if (error) {
  Serial.print("deserializeJson() failed: ");
  Serial.println(error.c_str());
  return;
}

JsonObject devices = doc["devices"];
led_status = devices["led_status"]; // true
rgb = devices["rgb"].as<String>(); // "0,0,0"
scheduled_time = devices["scheduled_time"].as<String>(); // "09:06 PM"
servo_delay = devices["servo_delay"]; // 700
servo_status = devices["servo_status"]; // false
led_animation= devices["led_animation"].as<String>();

//temperature = devices["temperature"]; // 33.99995

  }
