
use <e3dv6.scad>

detaillevel = 0;

module jheadmount(){
rotate([0,0,25]) translate([0,3.5,0])
  difference(){
      
      union(){
rotate([0,0,36]){
  rotate([0,0,0]){
      for (a = [-90:120:269]) {
        rotate([0, 0, a]) {
               union(){
                translate([0,-23,0]) cube([20,45,12.99]);
                    translate([10,-23,0]) cylinder(r=10, h=12.99);
               }
      }
      }

  }
  
  }
  
  
 translate([0,0,-4]) cylinder(r=10, r2=15, h=4);
  }
translate([0,0,13]) rotate([0,180,0]) print_part();



      for (a = [-90:120:269]) {
        rotate([0, 0, a]) {
                translate([0,25,15]) cylinder(r=1.6, h=80, $fn= 20, center=true);
          
      }
      }


}
}


module edge(){
        union(){
        for(y=[40:-5:-40]){
    translate([-40,0,y])
    union(){
cube([80,40,5]);
rotate([45,0,0]) cube([80,3.53,3.53]);
    }
    }
}
}



difference(){
    
jheadmount();
translate([0,3.53,4])edge();
}



difference(){
    
jheadmount();
rotate([180,3.53,0]) translate([0,0,-.5]) edge();
    
}


/* */

