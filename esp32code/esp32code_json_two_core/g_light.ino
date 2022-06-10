uint8_t gHue = 0; // rotating "base color" used by many of the patterns 
void light(){
 Serial.print("RGB : ");
 Serial.println(rgb);
 Serial.print("Led Animation : ");
 Serial.println(led_animation);
   int r=getValue(rgb,',',0).toInt();
  int g=getValue(rgb,',',1).toInt();
  int b=getValue(rgb,',',2).toInt();
  
//singlecolor
if(led_animation=="singlecolor"){
      for (int i = 0; i < NUM_LEDS; i++) {
    leds[i] = CRGB(r,g,b);
  }
  FastLED.show();
  }


//cylon
if(led_animation=="cylon"){
cylon();
}

  //rainbow
if(led_animation=="rainbow"){
  fill_rainbow( leds, NUM_LEDS, gHue, 7);
  FastLED.show();  
  EVERY_N_MILLISECONDS( 20 ) { gHue++; } // slowly cycle the "base color" through the rainbow

  }

  //sinelon
if(led_animation=="sinelon"){
  fadeToBlackBy( leds, NUM_LEDS, 20);
  int pos = beatsin16( 13, 0, NUM_LEDS-1 );
  leds[pos] += CHSV( gHue, 255, 192);
  FastLED.show();  
  EVERY_N_MILLISECONDS( 20 ) { gHue++; } // slowly cycle the "base color" through the rainbow

  }

    //pacific
if(led_animation=="pacifica"){
      for (int i = 0; i < NUM_LEDS; i++) {
    leds[i] = CRGB(r,g,b);
  }
  FastLED.show();
  }
  
  
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
