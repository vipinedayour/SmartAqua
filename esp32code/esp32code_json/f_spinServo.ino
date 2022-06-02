void spinservo(int sdelay){
    servo1.attach(servoPin);
    servo1.write(50);
    delay(sdelay);
    servo1.detach();
    servo_status=false;
  }
