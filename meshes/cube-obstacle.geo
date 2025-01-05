//+
SetFactory("OpenCASCADE");

// Bottom Edges
Point(1) = {-7, -3, -3, 1.0};
Point(2) = {7, -3, -3, 1.0};
Point(3) = {7, 3, -3, 1.0};
Point(4) = {-7, 3, -3, 1.0};

Line(1) = {1, 2};
Line(2) = {2, 3};
Line(3) = {3, 4};
Line(4) = {4, 1};

// Top Edges
Point(5) = {-7, -3, 3, 1.0};
Point(6) = {7, -3, 3, 1.0};
Point(7) = {7, 3, 3, 1.0};
Point(8) = {-7, 3, 3, 1.0};

Line(5) = {5, 6};
Line(6) = {6, 7};
Line(7) = {7, 8};
Line(8) = {8, 5};

// Vertical Edges
Line(9) = {1, 5};
Line(10) = {2, 6};
Line(11) = {3, 7};
Line(12) = {4, 8};

// Sides
Curve Loop(1) = {1, 2, 3, 4};
Curve Loop(2) = {5, 6, 7, 8};

Curve Loop(3) = {1, 10, 5, 9};
Curve Loop(4) = {2, 11, 6, 10};
Curve Loop(5) = {3, 12, 7, 11};
Curve Loop(6) = {4, 9, 8, 12};

Plane Surface(1) = {1};
Plane Surface(2) = {2};
Plane Surface(3) = {3};
Plane Surface(4) = {4};
Plane Surface(5) = {5};
Plane Surface(6) = {6};

Physical Surface("bottom", 10001) = {1};
Physical Surface("top", 10002) = {2};
Physical Surface("front", 10003) = {3};
Physical Surface("right", 10004) = {4};
Physical Surface("back", 10005) = {5};
Physical Surface("left", 10006) = {6};

// Cube Obstacle
Point(9) = {-0.5, -0.5, -0.5, 1.0};
Point(10) = {0.5, -0.5, -0.5, 1.0};
Point(11) = {0.5, 0.5, -0.5, 1.0};
Point(12) = {-0.5, 0.5, -0.5, 1.0};
Point(13) = {-0.5, -0.5, 0.5, 1.0};
Point(14) = {0.5, -0.5, 0.5, 1.0};
Point(15) = {0.5, 0.5, 0.5, 1.0};
Point(16) = {-0.5, 0.5, 0.5, 1.0};
Line(13) = {9, 10};
Line(14) = {10, 11};
Line(15) = {11, 12};
Line(16) = {12, 9};
Line(17) = {13, 14};
Line(18) = {14, 15};
Line(19) = {15, 16};
Line(20) = {16, 13};
Line(21) = {9, 13};
Line(22) = {10, 14};
Line(23) = {11, 15};
Line(24) = {12, 16};
Curve Loop(7) = {13, 14, 15, 16};
Curve Loop(8) = {17, 18, 19, 20};
Curve Loop(9) = {13, 22, 17, 21};
Curve Loop(10) = {14, 23, 18, 22};
Curve Loop(11) = {15, 24, 19, 23};
Curve Loop(12) = {16, 21, 20, 24};
Plane Surface(7) = {7};
Plane Surface(8) = {8};
Plane Surface(9) = {9};
Plane Surface(10) = {10};
Plane Surface(11) = {11};
Plane Surface(12) = {12};
Physical Surface("obstacle", 10007) = {7, 8, 9, 10, 11, 12};


// Volume
Surface Loop(1) = {2, 3, 1, 4, 5, 6};
Surface Loop(2) = {8, 9, 7, 10, 11, 12};
Volume(1) = {1, 2};
Physical Volume("domain", 100001) = {1};

