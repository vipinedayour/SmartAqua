void feedNow(){
  
    if(servo_status==true){
    Serial.println("Feeded now");
    digitalWrite(LED_BUILTIN, HIGH);
    spinservo(servo_delay);
    servo_status=false;
    Firebase.RTDB.setBool(&fbdo, "devices/servo_status", servo_status);
    digitalWrite(LED_BUILTIN, LOW);
    }

  }
