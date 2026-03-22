//+
SetFactory("OpenCASCADE");

// Box
Point(1) = {-7, -3, 0, 1.0};
Point(2) = {7, -3, 0, 1.0};
Point(3) = {7, 3, 0, 1.0};
Point(4) = {-7, 3, 0, 1.0};
Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};
Physical Curve("bottom", 1001) = {1};
Physical Curve("right", 1002) = {2};
Physical Curve("top", 1003) = {3};
Physical Curve("left", 1004) = {4};

// Cylinder
Point(5) = {-0.5, 0, 0, 1.0};
Point(6) = {0, -0.5, 0, 1.0};
Point(7) = {0.5, 0, 0, 1.0};
Point(8) = {0, 0.5, 0, 1.0};
Point(9) = {0, 0, 0, 1.0};
Circle(5) = {5, 9, 6};
Circle(6) = {6, 9, 7};
Circle(7) = {7, 9, 8};
Circle(8) = {8, 9, 5};
Physical Curve("obstacle", 1005) = {5, 6, 7, 8};

// Domain
Curve Loop(1) = {1, 2, 3, 4};
Curve Loop(2) = {5, 6, 7, 8};
Plane Surface(1) = {1, 2};
Physical Surface("domain", 10001) = {1};
