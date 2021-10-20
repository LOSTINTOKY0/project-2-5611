import java.util.ArrayList;

//PDEs and Integration
//CSCI 5611 Swinging Rope [Exercise]
//Stephen J. Guy <sjguy@umn.edu>

//NOTE: The simulation starts paused, press "space" to unpause

//TODO:

//  6. Add friction so that the rope eventually stops. An easy friction model is a scaled force 
//     in the opposite direction of a nodes current velocity. 



//Challenge:
//  - Set the top of the rope to be wherever the user’s mouse is, and allow the user to drag the rope around the scene.
//  - Keep the top of the rope fixed, but allow the user to click and drag one of the balls of the rope to move it around.
//  - Place a medium-sized, static 2D ball in the scene, have the nodes on the rope experience a “bounce” force if they collide with this ball.


//Create Window
String windowTitle = "Swinging Rope";
void setup() {
  size(400, 500, P3D);
  surface.setTitle(windowTitle);
  initScene();
}

//Simulation Parameters
float floor = 500;
int strings =19;
vec3 gravity = new vec3(0,400,0);
float radius = 5;
vec3 stringTop = new vec3(20,50,0);
float restLen = 15;
float mass = 1.0; //
float k = 200; //TRY-IT: How does changing k affect resting length of the rope?
float kv = 30; //TRY-IT: How big can you make kv?
float friction = -.0005;
//Initial positions and velocities of masses
static int maxNodes = 10;
ArrayList<vec3[]> pos= new ArrayList<vec3[]>();
ArrayList<vec3[]> vel = new ArrayList<vec3[]>();
ArrayList<vec3[]> acc = new ArrayList<vec3[]>();



int numNodes = 10;

void initScene(){
  for( int i = 0; i <strings; i++){
pos.add(new vec3[maxNodes]);
acc.add( new vec3[maxNodes]);
vel.add(new vec3[maxNodes]);
}
  for (int j = 0; j < strings; j++){
     for (int i = 0; i < numNodes; i++){
    pos.get(j)[i] = new vec3(0,0,0);
    pos.get(j)[i].x = stringTop.x*(j+1) + i;
    pos.get(j)[i].y = stringTop.y + 8*i; //Make each node a little lower
    vel.get(j)[i] = new vec3(0,0,0);
     }
}
}
 
void update(float dt){

  //Reset accelerations each timestep (momenum only applies to velocity)
  for (int j = 0; j < strings; j++){
  for (int i = 0; i < numNodes; i++){
    acc.get(j)[i] = new vec3(0,0,0);
    acc.get(j)[i].plus(gravity);
  }
}
  //Compute (damped) Hooke's law for each spring
    for (int j = 0; j < strings; j++){
  for (int i = 0; i < numNodes-1; i++){
    vec3 diff = pos.get(j)[i+1].minus(pos.get(j)[i]);
    float stringF = -k*(diff.length() - restLen);
    
    vec3 stringDir = diff.normalized();
    float projVbot = vel.get(j)[i].dot( stringDir);
    float projVtop = vel.get(j)[i+1].dot( stringDir);
    float dampF = -kv*(projVtop - projVbot);
    vec3 force = stringDir.times(stringF+dampF);
    acc.get(j)[i].plus(force.times((-1.0/mass)));
    acc.get(j)[i+1].plus(force.times((1.0/mass)));
    vel.get(j)[i].plus(vel.get(j)[i].times(friction));
    vel.get(j)[i+1].plus(vel.get(j)[i+1].times(friction));
  }
    }
  //Eulerian integration
    for (int j = 0; j < strings; j++){
  for (int i = 1; i < numNodes; i++){
    vel.get(j)[i].plus(acc.get(j)[i].times(dt));
    pos.get(j)[i].plus(vel.get(j)[i].times(dt));
  }
    }
  
  //Collision detection and response
    for (int j = 0; j < strings; j++){
  for (int i = 0; i < numNodes; i++){
    if (pos.get(j)[i].y+radius > floor){
      vel.get(j)[i].y *= -.9;
      pos.get(j)[i].y = floor - radius;
    }
  }
    }
  
}

//Draw the scene: one sphere per mass, one line connecting each pair
boolean paused = true;
void draw() {
  background(255,255,255);
  
  //update(1/(20*frameRate))
  if (!paused) {
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));
update(1/(20*frameRate));




};
  fill(0,0,0);
    for (int j = 0; j < strings; j++){
  for (int i = 0; i < numNodes-1; i++){
    pushMatrix();
    line(pos.get(j)[i].x,pos.get(j)[i].y,pos.get(j)[i+1].x,pos.get(j)[i+1].y);
    translate(pos.get(j)[i+1].x,pos.get(j)[i+1].y);
    sphere(radius);
    popMatrix();
  }
    }
  
  if (paused)
    surface.setTitle(windowTitle + " [PAUSED]");
  else
    surface.setTitle(windowTitle + " "+ nf(frameRate,0,2) + "FPS");
}

void keyPressed(){
  if (key == ' ')
    paused = !paused;
}