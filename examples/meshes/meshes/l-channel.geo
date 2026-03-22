//+
SetFactory("OpenCASCADE");

// Channel
Point(1) = {0, 0, 0, 1.0};
Point(2) = {4, 0, 0, 1.0};
Point(3) = {6, -2, 0, 1.0};
Point(4) = {8, -2, 0, 1.0};
Point(5) = {4, 2, 0, 1.0};
Point(6) = {0, 2, 0, 1.0};
Point(7) = {4, -2, 0, 1.0};
Line(1) = {1, 2};
Circle(2) = {2, 7, 3};
Line(3) = {3, 4};
Circle(4) = {4, 7, 5};
Line(5) = {5, 6};
Line(6) = {6, 1};

Physical Curve("inlet", 1001) = {6};
Physical Curve("outlet", 1002) = {3};
Physical Curve("lower", 1003) = {1, 2};
Physical Curve("upper", 1004) = {4, 5};

// Domain
Curve Loop(1) = {1, 2, 3, 4, 5, 6};
Plane Surface(1) = {1};
Physical Surface("domain", 10001) = {1};
