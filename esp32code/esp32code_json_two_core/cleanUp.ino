
void cleanup(){
  if(refill){
refill=false;
bringitdown=true;
    filtered_distance();
      while(dist<bottom_level){
    filtered_distance();
    digitalWrite(relay1,LOW);
    digitalWrite(relay2,HIGH);
    Serial.println("while1");
    }
    
  while(dist>top_level){
    filtered_distance();
    
    digitalWrite(relay2,LOW);
    digitalWrite(relay1,HIGH);
    Serial.println("while2");                                                                                                                                                                                            
    }
 
  digitalWrite(relay2,HIGH);
    }
    
  }

  void filtered_distance(){



      // 1. TAKING MULTIPLE MEASUREMENTS AND STORE IN AN ARRAY
  for (int sample = 0; sample < 20; sample++) {
    filterArray[sample] = distance();
    delay(30); // to avoid untrasonic interfering
  }

  // 2. SORTING THE ARRAY IN ASCENDING ORDER
  for (int i = 0; i < 19; i++) {
    for (int j = i + 1; j < 20; j++) {
      if (filterArray[i] > filterArray[j]) {
        float swap = filterArray[i];
        filterArray[i] = filterArray[j];
        filterArray[j] = swap;
      }
    }
  }

  // 3. FILTERING NOISE
  // + the five smallest samples are considered as noise -> ignore it
  // + the five biggest  samples are considered as noise -> ignore it
  // ----------------------------------------------------------------
  // => get average of the 10 middle samples (from 5th to 14th)
  double sum = 0;
  for (int sample = 5; sample < 15; sample++) {
    sum += filterArray[sample];
  }

  dist = sum / 10;

  // print the value to Serial Monitor
  Serial.print("distance: ");
  Serial.print(dist);
  Serial.println(" cm");


  
    }

  float distance(){
  
    digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  // Sets the trigPin on HIGH state for 10 micro seconds
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  
  // Reads the echoPin, returns the sound wave travel time in microseconds
  duration = pulseIn(echoPin, HIGH);
  
  // Calculate the distance
  checkdist = duration * SOUND_SPEED/2;
  if (checkdist!=0){
    distance_cm=checkdist;
    }
  
  return distance_cm;
  }
