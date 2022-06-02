void light(){
 Serial.print("RGB : ");
 Serial.println(rgb);
 Serial.print("Led Animation : ");
 Serial.println(led_animation);
   int r=getValue(rgb,',',0).toInt();
  int g=getValue(rgb,',',1).toInt();
  int b=getValue(rgb,',',2).toInt();

      for (int i = 0; i < NUM_LEDS; i++) {
    leds[i] = CRGB(r,g,b);
  }
  FastLED.show();
  }
      

String getValue(String data, char separator, int index)
{
  int found = 0;
  int strIndex[] = {0, -1};
  int maxIndex = data.length()-1;

  for(int i=0; i<=maxIndex && found<=index; i++){
    if(data.charAt(i)==separator || i==maxIndex){
        found++;
        strIndex[0] = strIndex[1]+1;
        strIndex[1] = (i == maxIndex) ? i+1 : i;
    }
  }

  return found>index ? data.substring(strIndex[0], strIndex[1]) : "";
}
