// maybe someday... ;)
//Maxim maxim;
//AudioPlayer theme_song;
//AudioPlayer sfx;
PImage[] colorbooks;
PImage arrow;
Boolean splash;
int c_image;
int gui_offset;
int buttonsize;
int image_page;
int bgcolor;
                     
void setup() {
  size(screen.width, screen.height*0.9); //ipad
  //size(screen.width/2, screen.height*0.85); //pc
  
  bgcolor = 255;
  background(bgcolor);
  c_image = 0;
  buttonsize = 40;
  gui_offset = buttonsize * 1.5;
  splash = true;
  image_page = 0;
  imageMode(CENTER);
  brush = new Brushes(3);

  //images
  colorbooks = loadImages("obrazki/img", ".png", 13);
  new_page = loadImage("gui/sticky_note.png");
  arrow = loadImage("gui/arrow.png");}


class Brushes {
  int current_brush, current_color, num_of_brushes;
  Boolean eraser;
  PImage[] brush_images;
  PImage eraser_image, eraser_selected;
  PShape heart_outline;
  PShape star_outline;
  color[] colors = {color(255,0,0), color(255,255,0), color(0,255,0), 
              color(0,255,255), color(0,0,255), color(255,0,255)};

  Brushes(int col) {
    current_brush = 0;
    current_color = col;
    eraser = false;
    num_of_brushes = 5;
    brush_images = loadImages("gui/brushes/brush", ".png", num_of_brushes);
    eraser_image = loadImage("gui/eraser.png");
    eraser_selected = loadImage("gui/eraser_selected.png");
    heart_outline = loadShape("heart2.svg");
    star_outline = loadShape("star.svg");}

  void get_all_colors() {
    return colors;}

  void get_color() {
    return current_color;}

  void change_current_color(int col) {
    current_color = col;}

  void change_brush() {
    if (eraser) {eraser = false;} 
    else {current_brush = (current_brush + 1) % num_of_brushes;}}

  void draw(int px, int py, int  valx, int valy) {
    if (!eraser) {
      if (current_brush == 0) { simple_brush(px, py, valx, valy);} 
      else if (current_brush == 1) { wide_brush(px, py, valx, valy);}
      else if (current_brush == 2) { hearts(valx, valy);}
      else if (current_brush == 3) { stars(valx, valy);}
      else if (current_brush == 4) { magic_wand(valx, valy);}}
    else {erase(px, py, valx, valy);}}

  void get_image() {
    return brush_images[current_brush];}

  void get_eraser_image() {
    if (eraser) { return eraser_selected;}
    else { return eraser_image;}}

  void eraser_on() {
    eraser = true;}

  void eraser_off() {
    eraser = false;}

  void erase(int px, int py, int valx, int valy) {
    stroke(bgcolor);
    strokeWeight(50);
    line(px, py, valx, valy);}

  void simple_brush(int px, int py, int valx, int valy) {
    stroke(colors[current_color]);
    strokeWeight(10);
    line(px, py, valx, valy);}

  void wide_brush(int px, int py, int valx, int valy) {
    stroke(colors[current_color]);
    strokeWeight(25);
    line(px, py, valx, valy);}

  void hearts(int valx, int valy) {
    heart_outline.disableStyle();
    stroke(0);
    strokeWeight(5);
    fill(colors[current_color]);
    pushMatrix();      
    translate(valx, valy);
    rotate(random(20));
    shape(heart_outline, 0, 0, 20, 20); 
    popMatrix();}

  void stars(int valx, int valy) {
    star_outline.disableStyle();
    stroke(0);
    strokeWeight(5);
    fill(colors[current_color]);
    pushMatrix();      
    translate(valx, valy);
    rotate(random(20));
    shape(star_outline, 0, 0, 20, 20); 
    popMatrix();}

  void magic_wand(int valx, int valy) {
    noFill();
    stroke(random(255), random(255), random(255));
    pushMatrix();
    translate(valx, valy);
    rotate(random(20));
    point(0+random(20),0+random(20)); 
    popMatrix();}
};


void splashscreen() {
  //fade + splash frame
  rectMode(CENTER);
  fill(0,5);
  rect(width/2,height/2,width,height);
  fill(255);
  rect(width/2,height/2,0.8 * width, 0.8 * height, 20);
  
  //top splash menu
  fill(200);
  rect(width/2, 0.15*height, 0.8 * width, 0.1 * height, 20, 20, 0, 0);
  
  image(arrow, 0.15*width, 0.15 * height, 0.05 * height * height/width,0.05 * height);
  pushMatrix();
  translate(0.85*width, 0.15 * height);
  scale(-1,1);
  image(arrow, 0,0, 0.05 * height * height/width,0.05 * height);
  popMatrix();
  
  fill(150);
  textSize(height/30);
  text("Choose image", width/2.5, 0.16*height);
 
  //main frame
  int i_row = 1;
  stroke(0);
  for (int i = (1 + 9 * image_page); i < (10 + 9 * image_page); i++) {
      picture = colorbooks[(i - 1) % (colorbooks.length - 1)];
      image(picture, 0.1 * width + 4*width/25 + 24*((i - 1) % 3) * width / 100,
          0.33 * height + (i_row-1) * 2 * height / 9, width / 5.2, (height / 5.2));
      if (i % 3 == 0) { i_row++;}}
  rectMode(CORNER);
}

void gui() {
  //gui bottom rect
  stroke(0);
  strokeWeight(3);
  fill(200);  
  rect(0, height - 1.4 * gui_offset, width, height-1.4 * gui_offset, 15);

  //gui images
  PImage brush_img = brush.get_image();
  PImage eraser_img = brush.get_eraser_image();
  image(brush_img, width - 2 * buttonsize + 1.1 * gui_offset / 2, height - 0.7 * gui_offset, 
        0.95 * gui_offset * brush_img.width / brush_img.height, 0.95 * gui_offset);
  image(eraser_img, width - 4 * buttonsize + 1.1 * gui_offset / 2, height - 0.7 * gui_offset, 
        2 * buttonsize, 2 * buttonsize * eraser_img.height / eraser_img.width);
  image(new_page, -20, -20, 200, 200 * new_page.height / new_page.width);  
  
  //colors
  color[] all_colors = brush.get_all_colors();

  for (int i = 1; i < 7; i++) {
      fill(all_colors[i-1]);
      if (i == brush.get_color() +1) {
          strokeWeight(7);
          rect(2*buttonsize*i-1.1*gui_offset/2, 
              height - 1.05 * gui_offset, 1.1 * buttonsize, 1.1 * buttonsize, 7);}  
      else {
          strokeWeight(4);
          rect(2*buttonsize*i-gui_offset/2, height - gui_offset, buttonsize, buttonsize, 7);}}
}


void splash_actions(int mX, int mY) {
  //outiside frame
  if ((abs(mX - width/2) > 0.4 * width) || (abs(mY-height/2) > 0.4 * height)) {
    splash = false;
    background(bgcolor);}

  //left arrow  
  else if (dist(mX, mY, 0.15*width, 0.15 * height) < 0.04 * height) {
      if (image_page > 0) {image_page--;}}

  //right arrow
  else if (dist(mX, mY, 0.85*width, 0.15 * height) < 0.04 * height) {image_page++;} 
  else { 
      int i_row = 1;
      for (int i = (1+9*image_page); i < (10+9*image_page); i++) {
        if (dist(mX, mY, 0.1 * width + 4*width/25 + 24*((i-1)%3)*width/100,
            0.33 * height + (i_row-1) * 2*height/9) < (2*width/25)) {
            splash = false;
            c_image = (i-1)%(colorbooks.length -1);
            background(bgcolor);
            break;}
        if (i%3 == 0) {i_row++;}}
  }
}

void gui_actions(int mX, int mY) {
  if (dist(mX,mY, 0, 0) < 60) { splash = true;}      
  //eraser   
  else if (dist(mX,mY, width-4*buttonsize+1.1*gui_offset/2, 
           height - 0.7 * gui_offset) < buttonsize) {
      brush.eraser_on();}
  //change  brush
  else if (dist(mX,mY, width-1.2*gui_offset + buttonsize, 
           height - 1.2 * gui_offset+buttonsize) < buttonsize) {
      brush.change_brush();}  
  //switch color
  else { 
      for (int i = 1; i < 7; i++) {
        if (dist(mX,mY, 2*buttonsize*i-gui_offset/2+0.5*buttonsize,
                 height - gui_offset+0.5*buttonsize) < 0.6 * buttonsize) {
          brush.eraser_off();
          brush.change_current_color(i-1);}}
  }
}

void draw() {
  if (splash) {splashscreen();}
  else {
      int pictureheight = 500 * colorbooks[c_image].height/colorbooks[c_image].width;
      image(colorbooks[c_image], width/2, (height-gui_offset)/2, 500, pictureheight);
      gui();}}

void mouseDragged() {
  if ((!splash) && (mouseY < height - 1.4 * gui_offset))
      { brush.draw(pmouseX, pmouseY, mouseX, mouseY);}}

void mousePressed() {
  if (splash) { splash_actions(mouseX, mouseY);}
  else { gui_actions(mouseX,mouseY);}}

void mouseReleased() {
// code that happens when the mouse button
// is released
}


