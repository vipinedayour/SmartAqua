void checkTime(){
  struct tm timeinfo;
  if(!getLocalTime(&timeinfo)){
    Serial.println("Failed to obtain time");
    return;
  }
  Serial.print("Current_time : ");
  Serial.println(&timeinfo, "%I:%M %p");
  strftime(current_time,12, "%I:%M %p", &timeinfo);
  Serial.print("scheduled_time : ");
 Serial.println(scheduled_time);
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
}
