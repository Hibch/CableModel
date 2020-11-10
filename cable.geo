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
