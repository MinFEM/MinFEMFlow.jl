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

// Domain
Curve Loop(1) = {1, 2, 3, 4};
Plane Surface(1) = {1};
Physical Surface("domain", 10001) = {1};
