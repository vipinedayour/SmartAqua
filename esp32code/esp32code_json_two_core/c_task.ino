void Task1code( void * pvParameters ){
  for(;;){
getData();
feedNow();
checkTime();
measuretemperature();
get_temperature_tds();
Serial.println(""); 
cleanup();
  }
}
