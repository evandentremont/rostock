//hull() {
 //   translate([15,10,0]) cube(5);
  //  sphere(10);
//}

use <e3dmount/e3dv6.scad>

use <platform.scad>

detaillevel = 0;

//translate([0,0,63]) rotate([0,180,90]) #print_part();


    diameter = 22.3;
    
    
    
    fan_xpos = 39;
    fan_ypos = 0;
    fan_zpos = 7;
    fan_angle = 60;
    fan_size = 50;
    
    cooler_height = -19;

//TODO: Make this more modular
module fan_mount(size){
    // this is set for 50mm. Need to check other sizes and find relationship.
    hole_offset = 0.5*size*0.8;
    hole_radius = 3.0 / 2;
    
    translate([fan_xpos, fan_ypos, fan_zpos])  rotate([0,fan_angle,0]) 
    difference(){
        // Main Fan block
        cube([size,size,2], center=true);
        
        // Main fan hole
        cylinder(r=(size/2)-2, h=5, center=true);
     
          
        for(x = [-hole_offset, hole_offset]){
            for(y= [-hole_offset, hole_offset]) {
                translate([x,y,0])cylinder(r=hole_radius, h=5, $fn = 20, center=true);
            }
        }
           

        
     }
    
    
}



module e3d_v6_heatsink(){
    diameter = 22.3;
    
    difference(){
        
        cube([diameter+1, diameter+1, 26], center=true);
        
        //Heatsink cut
        cylinder(r=(diameter / 2), h=(26.5), center = true);
        translate([-(diameter/2), 0,0]) cube([diameter, diameter, 26.5], center=true);
        
        // Hole for air to come in. This is also part of the airflow hull. 
        translate([(diameter/2)-1.9, 0,0]) cube([6, (diameter-4), 26.5-4-2], center=true);

    
    }
}


module heatsink_airflow(size){

    
    
         // Main fan hole
    difference(){
        
        //Outer Shell
        hull(){
                       translate([fan_xpos, fan_ypos, fan_zpos]) rotate([0,fan_angle,0])
                       difference(){
                            cylinder(r=(size/2)-2, h=1.5, center=true);
                           
                            translate([size/4,0,0]) cube([size/2,size,10], center=true);
                       }
                       
                       translate([(diameter/2)+0.5, 0,9]) 
                            cube([0.1, diameter+1,26.0], center=true);
           }
           
           // Inner Shell
         airflow(size);
           
           // Heatsink
           cylinder(r=(diameter / 2), h=(26.5), center = true);
           
           
    }
}






module airflow(size){
   // heatsink 
      hull(){
                   translate([fan_xpos, fan_ypos, fan_zpos]) rotate([0,fan_angle,0])  
                   difference(){
                        cylinder(r=(size/2)-2-1, h=1.6, center=true);
                        translate([(size/4)-0.25,0,0]) cube([size/2,size,10], center=true);
                   }
                   
                   translate([(diameter/2), 0,9]) 
                        cube([0.15, (diameter-4)-0.5, 26.5-4-2], center=true);
           }
           
           
       // cooler
           hull(){
                   translate([fan_xpos, fan_ypos, fan_zpos]) rotate([0,fan_angle,0])  
                   difference(){
                        cylinder(r=(size/2)-2-1, h=1.6, center=true);
                        translate([(-size/4)+0.25,0,0]) cube([size/2,size,10], center=true);
                   }
                   
                   translate([10, 0,cooler_height ]) 
                        rotate([0,-60,0])  cube([1.5, 11, 5], center=true);
           }
}



module printcool_airflow(size){
    diameter = 22.3;
    
    
         // Main fan hole
    difference(){
        
        //Outer Shell
        hull(){
                       translate([fan_xpos, fan_ypos, fan_zpos]) rotate([0,fan_angle,0])
                       difference(){
                            cylinder(r=(size/2)-2, h=1.5, center=true);
                            translate([-size/4,0,0]) cube([size/2,size,10], center=true);
                       }
                       
                       translate([10, 0,cooler_height]) 
                            rotate([0,-60,0])  cube([1, 12, 6], center=true);
           }
           
        airflow(size);
           
           // Heatsink
           cylinder(r=(diameter / 2), h=(26.5), center = true);
           
           
    }
}



module custom_platform(){


// make this come around the head a bit, possibly dyson airblade style
// Need to make the airflow modular so it can be pulled out of the carriage as well.
 translate([0,0,21]) printcool_airflow(fan_size);
 translate([0,0,21]) heatsink_airflow(fan_size);
translate([0,0,30]) e3d_v6_heatsink();
translate([0,0,21]) fan_mount(fan_size);












h=8;


difference(){
    union(){
rotate([0,0,90]) platform();




// Top ring
translate([0,0,46]) rotate([0,0,90]) difference(){
   cylinder(r=27, h=h, center=true);
   cylinder(r=23, h=(h)+1, center=true);
}
        
    
//Pillars
rotate([0,0,180]){
      for (a = [-90:120:269]) {
        rotate([0, 0, a]) {
    
                translate([0, 25, 0]) rotate([0,0,30])cylinder(r=5, h=50);
               
          
      }
      }

  }


  }

translate([0,0,21]) airflow(fan_size);
  
  
  
  rotate([0,0,180]){
      for (a = [-90:120:269]) {
        rotate([0, 0, a]) {
                // These need sized so theyre tappable.
                translate([0,25,15]) cylinder(r=1.5, h=80, $fn= 20, center=true);
          
      }
      }

  }
  
  
}


}

custom_platform();







