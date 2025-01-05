SetFactory("OpenCASCADE");
//Left Inner Half Circle
Point(1) = {-1.5, 0.0, 0.0, 1.0};
Point(2) = {-1.5, 1.0, 0.0, 1.0};
Point(3) = {-0.5, 0.0, 0.0, 1.0};
Point(4) = {-1.5, -1.0, 0.0, 1.0};
Circle(1) = {2, 1, 3};
Circle(2) = {3, 1, 4};

// Left Outer Half Circle
Point(5) = {-1.5, 2.0, 0.0, 1.0};
Point(6) = {0.0, 1.3, 0.0, 1.0};
Point(7) = {0.0, -1.3, 0.0, 1.0};
Point(8) = {-1.5, -2.0, 0.0, 1.0};
Ellipse(3) = {5, 1, 6};
Ellipse(4) = {7, 1, 8};
Line(5) = {2, 5};
Line(6) = {4, 8};

Physical Curve("upper", 1001) = {5};
Physical Curve("lower", 1002) = {6};

//Right Inner Circle
Point(9) = {1.5, 0.0, 0.0, 1.0};
Point(10) = {1.5, 1.0, 0.0, 1.0};
Point(11) = {2.5, 0.0, 0.0, 1.0};
Point(12) = {1.5, -1.0, 0.0, 1.0};
Point(13) = {0.5, 0.0, 0.0, 1.0};
Circle(7) = {10, 9, 11};
Circle(8) = {11, 9, 12};
Circle(9) = {12, 9, 13};
Circle(10) = {13, 9, 10};

// Right outer cirlce
Point(14) = {1.5, 2.0, 0.0, 1.0};
Point(15) = {3.5, 0.0, 0.0, 1.0};
Point(16) = {1.5, -2.0, 0.0, 1.0};
Ellipse(11) = {6, 9, 14};
Circle(12) = {14, 9, 15};
Circle(13) = {15, 9, 16};
Ellipse(14) = {16, 9, 7};

Physical Curve("wall", 1003) = {2, 1, 3, 11, 12, 13, 14, 4};
Physical Curve("hole", 1004) = {7, 8, 9, 10};

// Domain
Curve Loop(1) = {6, 2, 1, 5, 3, 11, 12, 13, 14, 4};
Curve Loop(2) = {7, 8, 9, 10};
Plane Surface(1) = {1, 2};
Physical Surface("domain", 10001) = {1};

