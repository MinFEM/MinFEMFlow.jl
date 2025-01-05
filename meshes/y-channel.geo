//+
SetFactory("OpenCASCADE");

// Channel
Point(1) = {0, 0, 0, 1.0};
Point(2) = {4, 0, 0, 1.0};
Point(3) = {6, -2, 0, 1.0};
Point(4) = {7.5, -2, 0, 1.0};
Point(5) = {4, 1.5, 0, 1.0};
Point(6) = {6.5, 4, 0, 1.0};
Point(7) = {6, 4, 0, 1.0};
Point(8) = {4, 2, 0, 1.0};
Point(9) = {0, 2, 0, 1.0};

Point(10) = {4, -2, 0, 1.0};
Point(11) = {4, 4, 0, 1.0};

Line(1) = {1, 2};
Circle(2) = {2, 10, 3};
Line(3) = {3, 4};
Circle(4) = {4, 10, 5};
Circle(5) = {5, 11, 6};
Line(6) = {6, 7};
Circle(7) = {7, 11, 8};
Line(8) = {8, 9};
Line(9) = {9, 1};

Physical Curve("inlet", 1001) = {9};
Physical Curve("outlet", 1002) = {3, 6};
Physical Curve("noslip", 1003) = {1, 2, 4, 5, 7, 8};

// Domain
Curve Loop(1) = {1, 2, 3, 4, 5, 6, 7, 8, 9};
Plane Surface(1) = {1};
Physical Surface("domain", 10001) = {1};
