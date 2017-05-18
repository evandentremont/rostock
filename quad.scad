
module mount(diameter){
    
    difference(){
        cylinder(h=4, r=diameter/2, center=true, $fn=32);
        cylinder(h=5, r=4.45, center=true);
        
        for( i = [0:1:3] ){
            rotate([0,0,i*90])
                translate([10,0,0])    
                    hull(){
                    // height = 4.8 
                    // width = 3.45
                    cylinder(h=5, r=3.45/2, center=true, $fn=100);
                    translate([-1.8, 0, 0]) cylinder(h=5, r=3.45/2, center=true,  $fn=100);
        }
    }
}
    
    
}

mount(27.7);

//mount(30.0);