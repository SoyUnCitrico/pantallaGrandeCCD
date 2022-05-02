import processing.video.*;

Movie saludo, meteo;
int s, m, h, d;
boolean restartMeteo = true;
boolean restartSaludo = true;
boolean esMomento = false;
boolean meteoFinalizado = true;
boolean saludoFinalizado = true;
//boolean activacion = false;
String fullTime;
//float saludoDuration = 33.033;
//float meteoDuration = 864.65546;

void setup() {
  //size(960, 200);
  fullScreen();
  //noStroke();
  background(0);
  meteo = new Movie(this, "meteorita.mov");
  //saludo = new Movie(this, "saludo.mov");
  saludo = new Movie(this, "meteorita.mov");
}

void draw() {
  s = second();
  m = minute();  // Values from 0 - 59
  h = hour();    // Values from 0 - 23
  fullTime = String.format("%02d:%02d:%02d", h, m, s);
//  meteoDuration = meteo.duration();
//  saludoDuration = saludo.duration();
//  println(saludoDuration);
//  println(meteoDuration);
  
  if (( h == 11 || h == 13 || h == 14 || h ==15 || h == 17) && (m == 0) && s == 0) {
  //if ((h == 9 || h == 11 || h == 13 || h ==15 || h == 17) && (m == 51) && s == 0) {
    esMomento = true;
    println("Es momento: ",esMomento);
  } 
  if(esMomento) {
    if(saludoFinalizado) {
      //esMomento = false;
      viewMeteo();
    } else viewSaludo();
  } else {
    viewSaludo(); 
  }
  
}

void movieEvent(Movie m) {
  m.read();
}

void viewSaludo() {
  if (restartSaludo) {
    esMomento = false;
    println("Es momento: ",esMomento);  
    meteo.pause();
    delay(100);
    background(0);
    saludo.jump(0.0);
    saludo.loop();
    saludo.volume(0.0);
    println("Playing Saludo");
    restartSaludo = false;
    restartMeteo = true;
    saludoFinalizado = false;
  }
  pushMatrix();
  background(0);
  image(saludo, 0, 0, 960, 144);
  stroke(255);
  textSize(40);
  text(fullTime, 10, 300);
  String dur = Float.toString(saludo.duration());
  String durAct = Float.toString(saludo.time());
  text(dur, 300, 300);
  text(durAct, 600, 300);
  popMatrix();
  if(esMomento) {
    pushMatrix();
    String mesajeActivacion = "Esperando fin de video para cambio";
    textAlign(LEFT);
    text(mesajeActivacion, 100, 400);
    popMatrix();
  }
  if(saludo.time() >= saludo.duration() - 0.05) {
    saludoFinalizado = true;
    esMomento = false;
    println("Saludo Finalizado");
  }
}

void viewMeteo() {
  if (restartMeteo) { 
    saludo.pause();
    delay(100);
    background(0);
    meteo.jump(0.0);
    meteo.play();
    meteo.volume(1.0);
    restartSaludo = true;
    restartMeteo = false;
    meteoFinalizado = false;
    println("Playing Meteo");
  }
  pushMatrix();
  background(0);
  image(meteo, 0, 0, 960, 144);
  textSize(30);
  textAlign(LEFT);
  text("Manifiesto - Meteorita", 10, 300);
  text(fullTime, 400, 300);
  String dur = Float.toString(meteo.duration());
  String durAct = Float.toString(meteo.time());
  text(dur, 600, 300);
  text(durAct, 800, 300);
  popMatrix();
  if(meteo.time() >= meteo.duration()- 0.05) {
    meteoFinalizado = true;
    println("Meteorita Finalizado");
  
   }  
}
