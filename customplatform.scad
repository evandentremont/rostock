//hull() {
 //   translate([15,10,0]) cube(5);
  //  sphere(10);
//}

use <e3dmount/e3dv6.scad>

use <platform.scad>

detaillevel = 0;

// The actual head is shorter for some reason..
//translate([0,0,55]) rotate([0,180,210]) #print_part();


    diameter = 22.3;
    
    
    
    fan_xpos = 32;
    fan_ypos = 0;
    fan_zpos = -2.5;
    fan_angle = 75;
    fan_size = 30;
    
    cooler_height = -22;
    
    heatsink_height = 22;

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
    diameter = 25;
    
    difference(){
        
        //cube([diameter+20, diameter+19, 26], center=true);
        cylinder(h=26, r=(diameter+21)/2, center=true);
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
            
               rotate([0,0,0])  translate([fan_xpos, fan_ypos, fan_zpos+0-1])  rotate([0,fan_angle,0]) 
                        cube([fan_size,fan_size,1], center=true);
            
            
                                              rotate([0,0,0])  translate([fan_xpos-5.5, fan_ypos, fan_zpos+0-1])  rotate([0,fan_angle,0]) 
                        cube([fan_size,fan_size,1], center=true);
            
            
                         
                       translate([(diameter/2)+01.5, 0,1]) 
                            cube([0.1, diameter+1,26.0], center=true);
           }
           
           // Inner Shell
         heatsink_air(size);
           
           // Heatsink
           cylinder(r=(diameter / 2), h=(26.5), center = true);
           
           
    }
}




module heatsink_air(size){
       // heatsink 
      hull(){
                   translate([fan_xpos, fan_ypos, fan_zpos]) rotate([0,fan_angle,0])  
               
                        cylinder(r=(size/2)-2-1, h=1.6, center=true);
                        
                   translate([(diameter/2), 1,0]) 
                        cube([0.15, (diameter-4)-0.5, 26.5-4-2], center=true);
           }
           
       }


module ring(){
difference(){
    
   
translate([0,0,4])  rotate_extrude()
translate([20, 0, 0])
circle(r = 4);
    
ring_air();
    
}
}

module ring_air(){
        translate([0,0,4])  rotate_extrude()
translate([20, 0, 0])
circle(r = 2.5);
    
    cooler_steps = 16;
    
    for(i=[0:cooler_steps]){
    
    rotate([90,0,i*(360/cooler_steps)]) translate([18,1,0])rotate([0,0,0]) cube([1,7,5],center=true);
    
    }

}
    
elbow_height = 17;

module printcool_air240 (){
    hull(){
     rotate([0,0,240])  translate([fan_xpos, fan_ypos, fan_zpos+21])  rotate([0,fan_angle,0]) cylinder(r=(fan_size/2)-2, h=5, center=true);
        
         translate([0,-20,elbow_height])rotate([0,0,0])sphere(r=2, h=5, center=true);
         translate([5,-20,elbow_height])rotate([0,0,0])sphere(r=2, h=5, center=true);         
        translate([-5,-20,elbow_height])rotate([0,0,0])sphere(r=2, h=5, center=true);
    }

    hull(){
         translate([0,-20,elbow_height])rotate([0,0,0])sphere(r=2, h=5, center=true);
         translate([5,-20,elbow_height])rotate([0,0,0])sphere(r=2, h=5, center=true);         
        translate([-5,-20,elbow_height])rotate([0,0,0])sphere(r=2, h=5, center=true);
        
         translate([0,-20,4])rotate([0,0,0])sphere(r=2, h=5, center=true);
         translate([5,-20,4])rotate([0,0,0])sphere(r=2, h=5, center=true);         
        translate([-5,-20,4])rotate([0,0,0])sphere(r=2, h=5, center=true);  }

}


module printcool_air120 (){
    hull(){
     rotate([0,0,120])  translate([fan_xpos, fan_ypos, fan_zpos+20])  rotate([0,fan_angle,0]) cylinder(r=(fan_size/2)-2, h=5, center=true);
    translate([0,20,elbow_height])rotate([0,0,0])sphere(r=2, h=5, center=true);
        
            translate([5,20,elbow_height])rotate([0,0,0])sphere(r=2, h=5, center=true);
        
            translate([-5,20,elbow_height])rotate([0,0,0])sphere(r=2, h=5, center=true);
    }

    hull(){
    translate([0,20,elbow_height])rotate([0,0,0])sphere(r=2, h=5, center=true);
        
            translate([5,20,elbow_height])rotate([0,0,0])sphere(r=2, h=5, center=true);
        
            translate([-5,20,elbow_height])rotate([0,0,0])sphere(r=2, h=5, center=true);

    translate([0,20,4])rotate([0,0,0])sphere(r=2, h=5, center=true);
        
            translate([5,20,4])rotate([0,0,0])sphere(r=2, h=5, center=true);
        
            translate([-5,20,4])rotate([0,0,0])sphere(r=2, h=5, center=true);
        
    }
}



module printcool_airflow240 (){
    
    difference(){
        union(){
            hull(){
             rotate([0,0,240])  translate([fan_xpos-1, fan_ypos, fan_zpos+20.5])  rotate([0,fan_angle,0]) 
                        cube([fan_size,fan_size,1], center=true);
        
                
                             rotate([0,0,240])  translate([fan_xpos-5.5, fan_ypos, fan_zpos+20.5-1])  rotate([0,fan_angle,0]) 
                        cube([fan_size,fan_size,1], center=true);
        
                
                
                //cylinder(r=(fan_size/2), h=2.5, center=true);
                
                //yikes...
                 translate([0,-20,elbow_height])rotate([0,0,0])sphere(r=3.75, h=5, center=true);
                            translate([-5,-20,elbow_height])rotate([0,0,0])sphere(r=3.75, h=5, center=true);
                            translate([5,-20,elbow_height])rotate([0,0,0])sphere(r=3.75, h=5, center=true);

            }

            hull(){
   
                                 translate([0,-20,elbow_height])rotate([0,0,0])sphere(r=3.75, h=5, center=true);
                            translate([-5,-20,elbow_height])rotate([0,0,0])sphere(r=3.75, h=5, center=true);
                            translate([5,-20,elbow_height])rotate([0,0,0])sphere(r=3.75, h=5, center=true);


                 translate([0,-20,4])rotate([0,0,0])sphere(r=3.75, h=5, center=true);
                            translate([-5,-20,4])rotate([0,0,0])sphere(r=3.75, h=5, center=true);
                            translate([5,-20,4])rotate([0,0,0])sphere(r=3.75, h=5, center=true);

            }
        }
        printcool_air240();
    }

}



module printcool_airflow120 (){
    difference(){
        union(){
            
    hull(){

          rotate([0,0,120])  translate([fan_xpos-1, fan_ypos, fan_zpos+20.5])  rotate([0,fan_angle,0]) 
                       cube([fan_size,fan_size,1], center=true);
        
                              rotate([0,0,120])  translate([fan_xpos-5.5, fan_ypos, fan_zpos+20.5-1])  rotate([0,fan_angle,0]) 
                        cube([fan_size,fan_size,1], center=true);
        
                
        
    translate([0,20,elbow_height])rotate([0,0,0])sphere(r=3.75, h=5, center=true);
            translate([-5,20,elbow_height])rotate([0,0,0])sphere(r=3.75, h=5, center=true);
            translate([5,20,elbow_height])rotate([0,0,0])sphere(r=3.75, h=5, center=true);
    }

    hull(){


    translate([0,20,elbow_height])rotate([0,0,0])sphere(r=3.75, h=5, center=true);
            translate([-5,20,elbow_height])rotate([0,0,0])sphere(r=3.75, h=5, center=true);
            translate([5,20,elbow_height])rotate([0,0,0])sphere(r=3.75, h=5, center=true);
        
        
    translate([0,20,4])rotate([0,0,0])sphere(r=3.75, h=5, center=true);
            translate([-5,20,4])rotate([0,0,0])sphere(r=3.75, h=5, center=true);
            translate([5,20,4])rotate([0,0,0])sphere(r=3.75, h=5, center=true);
    }
    
            }
        printcool_air120();
    }
    
}






module custom_platform(){


// make this come around the head a bit, possibly dyson airblade style
// Need to make the airflow modular so it can be pulled out of the carriage as well.






h=8;


difference(){
    union(){
        ring();
        printcool_airflow240 ();
printcool_airflow120 ();


rotate([0,0,90]) platform();
        
        
        
rotate([0,0,240]){
    translate([0,0,21]) fan_mount(fan_size);

}


rotate([0,0,120]){
    translate([0,0,21]) fan_mount(fan_size);
}
rotate([0,0,0]){
    translate([0,0,21]) fan_mount(fan_size);
    translate([0,0,21]) heatsink_airflow(fan_size);
    translate([0,0,heatsink_height]) e3d_v6_heatsink();
}







// ring


translate([0,0,12]) rotate([0,0,90]) difference(){
   cylinder(r=27, h=h, center=true);
   cylinder(r=23, h=(h)+1, center=true);
}

   
//Pillars
rotate([0,0,120]){
      for (a = [-90:120:269]) {
        rotate([0, 0, a]) {
    
                translate([0, 25, 21])  cylinder(r=4, h=42, center=true);
               
                translate([0,31.5,2.25]) cube([fan_size, 10.5,4.5], center=true);
         
               
              //  translate([4,21,2.25]) rotate([fan_angle,0,90])cube([8, 30,8]);
      //          translate([-4,29,2.25]) rotate([fan_angle,0,270])cube([8, 30,8]);
      }
       
      }
      
 

  }
  


  }

difference(){
    union(){
                      printcool_air240();
       printcool_air120();
        ring_air();
        
        rotate([0,0,0]){
            translate([0,0,21]) heatsink_air(fan_size);
        }
    }
    

    // posts through the fan holes. 
      rotate([0,0,120]){
      for (a = [-90:120:269]) {
        rotate([0, 0, a]) {
                // These may need sized so theyre tappable.
            hull(){
            //        translate([0,22,15]) cylinder(r=0.5, h=80, $fn= 20, center=true);
                    //translate([0,25,15]) cylinder(r=3.5, h=80, $fn= 20, center=true);
               //     translate([0,27,15]) cylinder(r=1.5, h=80, $fn= 20, center=true);
      }
      }
      }

  }
  
}


 
  
  rotate([0,0,120]){
      for (a = [-90:120:269]) {
        rotate([0, 0, a]) {
                // These may need sized so theyre tappable.
                translate([0,25,15]) cylinder(r=2.5, h=80, $fn= 20, center=true);
            // countersink on bottom
            translate([0,25,0]) cylinder(r=3.5, h=4, $fn= 20, center=true);
      }
      }

  }
  
  
  // Fan wires hole.
  difference(){
            translate([0,17,0]) rotate([0,90,90])cylinder(r=3, h=30, $fn=16);
     //   #    translate([0,17,0]) rotate([0,90,90])cylinder(r=4, h=14, $fn=16);
    

      translate([0,15,-4]) rotate([0,90,90])cube([8,8,60], center=true);
    
  }
  
}


 


}

custom_platform();







