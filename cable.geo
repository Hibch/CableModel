Include "cable_data.geo";

Mesh.Algorithm = 6;
// 2D mesh algorithm (1: MeshAdapt, 2: Automatic, 3: Initial mesh only, 5: Delaunay, 6: Frontal-Delaunay, 7: BAMG, 8: Frontal-Delaunay for Quads, 9: Packing of Parallelograms)
Mesh.ElementOrder = 1; // or 2
SetFactory("OpenCASCADE");

dist_cab = dc +2*(ti+txlpe+to+tt+tms+tacs);
h = dist_cab *Sin(Pi/3); // height of equilateral triangle
x0 = 0; y0= 2*h/3;
x1 = -dist_cab/2; y1 = -h/3;
x2 = dist_cab/2; y2 = -h/3;

sur_wire()={};
  sur_wire(0) = news; Disk(news) = {x0,y0,0.,dc/2};
  sur_wire(1) = news; Disk(news) = {x1,y1,0.,dc/2};
  sur_wire(2) = news; Disk(news) = {x2,y2,0.,dc/2};

sur_screen_in()={};
  sur_screen_in(0) = news; Disk(news) = {x0,y0,0.,dc/2+ti};
  sur_screen_in(1) = news; Disk(news) = {x1,y1,0.,dc/2+ti};
  sur_screen_in(2) = news; Disk(news) = {x2,y2,0.,dc/2+ti};

sur_insul()={};
  sur_insul(0) = news; Disk(news) = {x0,y0,0.,dc/2+ti+txlpe};
  sur_insul(1) = news; Disk(news) = {x1,y1,0.,dc/2+ti+txlpe};
  sur_insul(2) = news; Disk(news) = {x2,y2,0.,dc/2+ti+txlpe};

sur_screen_out()={};
  sur_screen_out(0) = news; Disk(news) = {x0,y0,0.,dc/2+ti+txlpe+to};
  sur_screen_out(1) = news; Disk(news) = {x1,y1,0.,dc/2+ti+txlpe+to};
  sur_screen_out(2) = news; Disk(news) = {x2,y2,0.,dc/2+ti+txlpe+to};

sur_tape()={};
  sur_tape(0) = news; Disk(news) = {x0,y0,0.,dc/2+ti+txlpe+to+tt};
  sur_tape(1) = news; Disk(news) = {x1,y1,0.,dc/2+ti+txlpe+to+tt};
  sur_tape(2) = news; Disk(news) = {x2,y2,0.,dc/2+ti+txlpe+to+tt};

sur_metal_sheath()={};
  sur_metal_sheath(0) = news; Disk(news) = {x0,y0,0.,dc/2+ti+txlpe+to+tt+tms};
  sur_metal_sheath(1) = news; Disk(news) = {x1,y1,0.,dc/2+ti+txlpe+to+tt+tms};
  sur_metal_sheath(2) = news; Disk(news) = {x2,y2,0.,dc/2+ti+txlpe+to+tt+tms};

sur_anti_cor_sheath()={};
  sur_anti_cor_sheath(0) = news; Disk(news) = {x0,y0,0.,dc/2+ti+txlpe+to+tt+tms+tacs};
  sur_anti_cor_sheath(1) = news; Disk(news) = {x1,y1,0.,dc/2+ti+txlpe+to+tt+tms+tacs};
  sur_anti_cor_sheath(2) = news; Disk(news) = {x2,y2,0.,dc/2+ti+txlpe+to+tt+tms+tacs};

r_bed_in = 2*h/3+dist_cab/2;

sur_fill()={};
  sur_fill(0) = news; Disk(news) = {0,0.,0.,r_bed_in};
sur_bed()={};
  sur_bed(0) = news; Disk(news) = {0,0.,0.,r_bed_in+tbed};
sur_arm()={};
  sur_arm(0) = news; Disk(news) = {0,0.,0.,r_bed_in+tbed+ta};
sur_out()={};
  sur_out(0) = news; Disk(news) = {0,0.,0.,r_bed_in+tbed+ta+tos};

BooleanFragments{
  Surface{sur_wire(), sur_screen_in(), sur_insul(), sur_screen_out(), sur_tape(), sur_metal_sheath(), sur_anti_cor_sheath(), sur_fill(), sur_bed(), sur_arm(), sur_out()};
  Delete;
  }{}

sur_wire() = {1,2,3};
sur_screen_in() = {4,5,6};
sur_insul() = {7,8,9};
sur_screen_out() = {10,11,12};
sur_tape() = {13,14,15};
sur_metal_sheath() = {16,17,18};
sur_anti_cor_sheath() = {19,20,21};
sur_fill() = {22,23,24,25};
sur_bed() = {26};
sur_arm() = {27};
sur_out() = {28};

/*
sur_wire_cover0() = {sur_wire(0), sur_screen_in(0), sur_insul(0), sur_screen_out(0), sur_tape(0), sur_metal_sheath(0), sur_anti_cor_sheath(0)};
sur_wire_cover1() = {sur_wire(1), sur_screen_in(1), sur_insul(1), sur_screen_out(1), sur_tape(1), sur_metal_sheath(1), sur_anti_cor_sheath(1)};
sur_wire_cover2() = {sur_wire(2), sur_screen_in(2), sur_insul(2), sur_screen_out(2), sur_tape(2), sur_metal_sheath(2), sur_anti_cor_sheath(2)};
*/

//===============================================
//           Around the cable
//===============================================
all_sur_cable() = Surface{:};

// electromagnetic analysis domain
sur_EMdom = news; Disk(news) = {0.,0.,0., dinf/2};
BooleanDifference(news) = {Surface{sur_EMdom}; Delete; }{ Surface{all_sur_cable()}; };

sur_EMdom = news-1;

// thermal analysis domain
sur_soil = news; Rectangle(news) = {-dinf_th, -dinf_th, 0, 2*dinf_th, dinf_th*depth_cable};
BooleanDifference(news) = {Surface{sur_soil}; Delete; }{ Surface{all_sur_cable()}; };
sur_soil =  news-1;

sur_waterout = news; Rectangle(news) = {-dinf_th, depth_cable, 0, 2*dinf_th, dinf_th_water};

all_sur() = Surface{:};
BooleanFragments{ Surface{all_sur()}; Delete; }{}
sur_soil = {52}; // the EM dom has been substracted
//Printf("",all_sur());
all_sur() = Surface{:};
bnd() = CombinedBoundary{ Surface{all_sur()}; };
Printf("",bnd());

bnd_EMdom() = CombinedBoundary{ Surface{sur_EMdom}; };
Printf("",bnd_EMdom());


// Adjusting the characteristic mesh size
cl = dtot/s;
// Characteristic length { Point{:} } = cl;
Characteristic Length { PointsOf{ Surface{sur_bed(), sur_arm(), sur_out()}; } } = cl/16;
Characteristic Length { PointsOf{ Surface{sur_wire(), sur_screen_in(), sur_insul(), sur_screen_out()}; } } = cl/32;
Characteristic Length { PointsOf{ Surface{sur_tape(), sur_metal_sheath(), sur_anti_cor_sheath()}; } } = cl/32;
Characteristic Length { PointsOf{ Surface{sur_fill()}; } } = cl/32;
Characteristic Length { PointsOf{ Line{bnd_EMdom(1)}; } } = 2*cl;
Characteristic Length { PointsOf{ Surface{sur_waterout()}; Line{bnd()}; } } = 5*cl;


//===============================================
//  Physical regions => link to pro-file and FE
//===============================================

Physical Surface("wire 1", WIRE+0) = sur_wire(0);
Physical Surface("wire 2", WIRE+1) = sur_wire(2);
Physical Surface("wire 3", WIRE+2) = sur_wire(1);

Physical Surface("conductour screen", CONDUCTOR_SCREEN) = sur_screen_in();
Physical Surface("XLPE", XLPE) = sur_insul();
Physical Surface("insulation screen", INSULATION_SCREEN) = sur_screen_out();
Physical Surface("swelling tape", TAPE) = sur_tape();
Physical Surface("metallic sheath", METALLIC_SHEATH) = sur_metal_sheath();
Physical Surface("anti corrosion sheath", ANTI_CORR_SHEATH) = sur_anti_cor_sheath();

Physical Surface("water in cable", WATER_IN) = {sur_fill()};

Physical Surface("bedding", BEDDING) = sur_bed();
Physical Surface("armour", ARMOUR) = sur_arm();
Physical Surface("outer serving", OUTER_SERVING) = sur_out();

Physical Surface("Soil (EM)", SOIL_EM) = sur_EMdom();
Physical Surface("Soil (thermal)", SOIL_TH) = sur_soil();
Physical Surface("Water above soil", WATER_OUT) = sur_waterout();

Physical Line("Outer boundary (EM)", OUTBND_EM) = bnd_EMdom(1);
Physical Line("Outer boundary (TH)", OUTBND_TH) = bnd();
Physical Line("Water/soil interface", INTERFACE_WATER_SOIL) = 38;
