/* 
 create a sphere around a led cube
 fully parametric
 this code is not 100% accurate yet, but close enough to relase it for further improvement

 -overflo 9/2022

Free software in the public domain (ab)use at will.

*/


// number of leds in one row
leds=8;
//distance between leds center to center
led_distance=7;

// this could be something else but lets calculate it for startes
cubesize= leds*led_distance;

// how thick the walld should be to fit between the leds
wallthickness=0.2;

// this could be something else 
sphere_dia=cubesize*1.75;




module grid()
{
 // we cut out a 45degree piece   
 intersection()
 {  

   // unionize all fins
    union()
    {
    // make fins in one direction on the plane starting from center   
     for(i=[0:leds/2])
     {
      //echo((45/leds)*i);
     translate([(i*led_distance),0,(cubesize/2)])   rotate([0,(90/leds)*i,0]) cube([wallthickness,1000,1000] ,center=true);   
     }
     // make fins on the other side of the center  
     for(i=[0:leds/2])
     {
      translate([-(i*led_distance),0,(cubesize/2)])   rotate([0,-(90/leds)*i,0]) cube([wallthickness,1000,1000] ,center=true);   
     }
    } //union

    // create a "pyramid" to cut off the finsfrom cube side to furthest away edge
    hull()
    {
     translate([0,0,500]) cube([1000,1000,1],center=true);
     translate([0,0,cubesize/2]) cube([cubesize,cubesize,1],center=true);
    }
 }  //intersection



}



// make a side from 2 grids at a 90 degree rotated axis
module sidegrid()
{
    grid();
    rotate([0,0,90]) grid();
}





//start of  actual model

// the cube in the middle
 color("red") cube([cubesize,cubesize,cubesize],center=true);

// we want to have a sphere at the end..
intersection()
{
 
   // render all the sides / grids 
 union()
 {   
  sidegrid();
  rotate([90,0,0]) sidegrid();   
     
  rotate([-90,0,0]) sidegrid();   
  rotate([-90,0,90]) sidegrid();   

  rotate([180,0,0]) sidegrid();   
  rotate([-90,0,-90]) sidegrid();   

 }
 // remove everything thats not inside out sphere
 // this could be ANY shape..
 sphere(d=sphere_dia,$fn=100);


}





