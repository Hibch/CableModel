Include "cable_data.geo";

Mesh.Algorithm = 6;
// 2D mesh algorithm (1: MeshAdapt, 2: Automatic, 3: Initial mesh only, 5: Delaunay, 6: Frontal-Delaunay, 7: BAMG, 8: Frontal-Delaunay for Quads, 9: Packing of Parallelograms)
Mesh.ElementOrder = 1; // or 2
SetFactory("OpenCASCADE");
