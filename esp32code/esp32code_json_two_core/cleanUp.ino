void cleanup(){
  if(refill){
refill=false;
bringitdown=true;
    distance();
      while(dist<6){
    distance();
    digitalWrite(relay1,LOW);
    digitalWrite(relay2,HIGH);
    Serial.println("while1");
    }
    
  while(dist>3){
    distance();
    
    digitalWrite(relay2,LOW);
    digitalWrite(relay1,HIGH);
    Serial.println("while2");
    
//    Firebase.RTDB.setBool(&fbdo, "devices/refill", refill);                                                                                                                                                                                              
    }
 
  digitalWrite(relay2,HIGH);
//getData();
    }
    
  }

  void distance(){
  
    digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  // Sets the trigPin on HIGH state for 10 micro seconds
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  
  // Reads the echoPin, returns the sound wave travel time in microseconds
  duration = pulseIn(echoPin, HIGH);
  
  // Calculate the distance
  dist = duration * SOUND_SPEED/2;
  
  // Convert to inches
  distanceInch = dist * CM_TO_INCH;
  
  // Prints the distance in the Serial Monitor
  Serial.print("Distance (cm): ");
  Serial.println(dist);
  delay(1000);
  }
