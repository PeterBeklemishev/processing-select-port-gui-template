
import controlP5.*;
import java.util.*;
import processing.serial.*;

ControlP5 cp5;
Serial serial;

String[] ports;
String selectedPort;
Boolean connected = false;

int portBaudrate = 9600;

void setup() {
  //set your size
  size(400, 400);
  
  cp5 = new ControlP5(this);
  ports = Serial.list();
  
  cp5.addScrollableList("dropdown")
    /*    
      Set your own label, size, pozition, etc for dropdown
    */
     .setLabel("SELECT PORT")
     .setPosition(10, 100)
     .setSize(200, 100)
     .setBarHeight(20)
     .setItemHeight(20)
     .addItems((List)Arrays.asList(ports))
     .setType(ScrollableList.DROPDOWN);
     
   cp5.addButton("connectBtn")
     .setLabel("connect")
     .setValue(1555)
     .setPosition(210,100)
     .setSize(40,19);
     
   /*
   Put your stuff here   
   */

}

void draw() {
  if (!connected) {
    //Do here what you want to do, if not connected to port
    background(200);
    
  } else {
    //connected, do stuff you want
    background(100);
    
  }
}

/*
  Magic, don't touch pls
*/
void dropdown(int n) {
  selectedPort = ports[n];
  println("you select "+selectedPort);
  CColor c = new CColor();
  c.setBackground(color(255,0,0));
  cp5.get(ScrollableList.class, "dropdown").getItem(n).put("color", c);
}
void connectBtn(int n){
  if (selectedPort != null && !selectedPort.isEmpty()){
    serial = new Serial(this, selectedPort, portBaudrate);
    println("connected to "+selectedPort+" on "+portBaudrate+" baud");
    connected = true;
    cp5.get(ScrollableList.class, "dropdown").hide();
    cp5.get(Button.class, "connectBtn").hide();
  }
}
void keyPressed() {
 if(key == ENTER){
   connectBtn(1);
 }
}
