
//Small vector library
// Represents a vector as 3 floats

public class vec3{
  float x;
  float y;
  float z;

  public vec3(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }
  public vec3(){
  this.x = 0;
  this.y = 0;
  this.z = 0;
}

  //Clamp each component (used to clamp pixel colors)
  vec3 clampTo1(){
    return new vec3(min(x,1),min(y,1),min(z,1));
  }

  //Compute vector length (you may also want length squared)
  float length(){
    return sqrt(x*x+y*y+z*z);
  }

  //Create a unit-length vector
  vec3 normalized(){
    float len = sqrt(x*x+y*y+z*z);
    return new vec3(x/len,y/len,z/len);
  }



//Multiply float and vector
//TODO: you probably also want to multiply vector and float
vec3 times(float f){
  return new vec3(this.x*f,this.y*f,this.z*f);
}

//Vector-vector dot product
 float dot(vec3 b){
  return this.x*b.x + this.y*b.y + this.z*b.z;
}

//Vector-vector cross product
vec3 cross( vec3 b){
  return new vec3(this.y*b.z - this.z*b.y, this.z*b.x - this.x*b.z, this.x*b.y-this.y*b.x);
}

//Vector addition
 void plus(vec3 b){
  this.x+=b.x;
  this.y+=b.y;
  this.z+=b.z;
}

 void mul(float f){
  this.x*=f;
  this.y*=f;
  this.z*=f;
}


//Vector subtraction
 void sub( vec3 b){
   this.x-=b.x;
   this.y-=b.y;
   this.z-=b.z;
}

  public void normalize(){
    float magnitude = sqrt(x*x + y*y + z*z);
    x /= magnitude;
    y /= magnitude;
    z/= magnitude;
  }
  
//Vector subtraction
 vec3 minus( vec3 b){
  return new vec3(this.x-b.x, this.y-b.y, this.z-b.z);
}

}
