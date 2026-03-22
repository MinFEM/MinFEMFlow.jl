//+
SetFactory("OpenCASCADE");

// Channel
Point(1) = {-4, 0, 0, 1.0};
Point(2) = {-2, 0, 0, 1.0};
Point(3) = {-2, 4, 0, 1.0};
Point(4) = {0, 6, 0, 1.0};
Point(5) = {2, 4, 0, 1.0};
Point(6) = {2, 0, 0, 1.0};
Point(7) = {4, 0, 0, 1.0};
Point(8) = {4, 4, 0, 1.0};
Point(9) = {0, 8, 0, 1.0};
Point(10) = {-4, 4, 0, 1.0};
Point(11) = {0, 4, 0, 1.0};
Line(1) = {1, 2};
Line(2) = {2, 3};
Circle(3) = {3, 11, 4};
Circle(4) = {4, 11, 5};
Line(5) = {5, 6};
Line(6) = {6, 7};
Line(7) = {7, 8};
Circle(8) = {8, 11, 9};
Circle(9) = {9, 11, 10};
Line(10) = {10, 1};

Physical Curve("inlet", 1001) = {1};
Physical Curve("outlet", 1002) = {6};
Physical Curve("inner", 1003) = {2, 3, 4, 5};
Physical Curve("outer", 1004) = {7, 8, 9, 10};

// Domain
Curve Loop(1) = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10};
Plane Surface(1) = {1};
Physical Surface("domain", 10001) = {1};
