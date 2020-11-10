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
  sur_wire(0) = news; Disk(news) = {x0,y0,0,dc/2};
  sur_wire(1) = news; Disk(news) = {x1,y1,0,dc/2};
  sur_wire(2) = news; Disk(news) = {x2,y2,0,dc/2};

sur_screen_in()={};
  sur_screen_in(0) = news; Disk(news) = {x0,y0,0,dc/2+ti};
  sur_screen_in(1) = news; Disk(news) = {x1,y1,0,dc/2+ti};
  sur_screen_in(2) = news; Disk(news) = {x2,y2,0,dc/2+ti};

sur_insul()={};
  sur_insul(0) = news; Disk(news) = {x0,y0,0,dc/2+ti+txlpe};
  sur_insul(1) = news; Disk(news) = {x1,y1,0,dc/2+ti+txlpe};
  sur_insul(2) = news; Disk(news) = {x2,y2,0,dc/2+ti+txlpe};

sur_screen_out()={};
  sur_screen_out(0) = news; Disk(news) = {x0,y0,0,dc/2+ti+txlpe+to};
  sur_screen_out(1) = news; Disk(news) = {x1,y1,0,dc/2+ti+txlpe+to};
  sur_screen_out(2) = news; Disk(news) = {x2,y2,0,dc/2+ti+txlpe+to};

sur_tape()={};
  sur_tape(0) = news; Disk(news) = {x0,y0,0,dc/2+ti+txlpe+to+tt};
  sur_tape(1) = news; Disk(news) = {x1,y1,0,dc/2+ti+txlpe+to+tt};
  sur_tape(2) = news; Disk(news) = {x2,y2,0,dc/2+ti+txlpe+to+tt};

sur_metal_sheath()={};
  sur_metal_sheath(0) = news; Disk(news) = {x0,y0,0,dc/2+ti+txlpe+to+tt+tms};
  sur_metal_sheath(1) = news; Disk(news) = {x1,y1,0,dc/2+ti+txlpe+to+tt+tms};
  sur_metal_sheath(2) = news; Disk(news) = {x2,y2,0,dc/2+ti+txlpe+to+tt+tms};

sur_anti_cor_sheath()={};
  sur_anti_cor_sheath(0) = news; Disk(news) = {x0,y0,0,dc/2+ti+txlpe+to+tt+tms+tacs};
  sur_anti_cor_sheath(1) = news; Disk(news) = {x1,y1,0,dc/2+ti+txlpe+to+tt+tms+tacs};
  sur_anti_cor_sheath(2) = news; Disk(news) = {x2,y2,0,dc/2+ti+txlpe+to+tt+tms+tacs};

d_bed_in = 2*h/3+dist_cab/2;

sur_bed()={};
  sur_bed(0) = news; Disk(news) = {0,0,0,d_bed_in};
sur_arm()={};
  sur_arm(0) = news; Disk(news) = {0,0,0,d_bed_in+ta};
sur_out()={};
  sur_out(0) = news; Disk(news) = {0,0,0,d_bed_in+ta+tos};
