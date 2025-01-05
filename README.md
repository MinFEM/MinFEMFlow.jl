# MinFEMFlow.jl

## A minimal Stokes flow solver for MinFEM

[![][license-badge]][license-url]
[![][test-badge]][test-url]

* The purpose of this package is to provide an easy and minimalistic solver for Stokes flow based on first order finite elements.

* This code imports meshes created via GMSH and outputs VTK format for Paraview.

* Problems are in general considered to be two-dimensional.  
While 3D is technically supported, the performance is not suitable for reasonable problems.

## Usage

First, we need to add the MinFEMFlow package to our Julia installation.
Thus, open the julia REPL, hit the **]** key and type

```
add MinFEMFlow
test MinFEMFlow
```

Now, we can go through a basic example.
We start the code by including the modules.
Here, also the base module `MinFEM` itself is required to import the mesh and specify the boundaries in the following.
```
using MinFEM, MinFEMFlow
```


Import a mesh created via `gmsh` and specify boundary regions by the following commands.
```julia
mesh::Mesh = import_mesh("meshes/channel-4.msh");
noSlipBoundary = select_boundaries(mesh, 1001, 1003, 1004)
inflowBoundary = select_boundaries(mesh, 1004)
```

Then, we need to define an inflow function that will be prescribed as a Dirichlet condition on the corresponding boundary.
Here, we use the bounding box to obtain an appropriate scaling of the cosine function.
Of course, since you import a custom mesh, you could also hard code this information.
In particular, the inflow function has to depend on the coordinates of your mesh. 
```julia
box = boundingbox(mesh)
width = box[1][2]-box[2][2]
inflow(x) = [cos(pi*abs(x[2])/width), 0.0]
```

With this information, we can create a `FlowSolver` object that contains the solution for the Stokes flow.
```julia
flow = StokesFlowSolver(mesh, inflowBoundary, noSlipBoundary, inflow)
```

Finally, we can call the solve function which assembles the linear system, solves it and stores the solution as well as computation time.
The solution can then also be written to file for visualization.
```julia
solve!(flow)
write_to_vtk(flow, "channel")
```

[license-url]: https://github.com/MinFEM/MinFEM.jl/blob/master/LICENSE
[license-badge]: https://img.shields.io/badge/License-MIT-brightgreen.svg
[test-url]: https://github.com/MinFEM/MinFEMFlow.jl/actions/workflows/test.yml
[test-badge]: https://github.com/MinFEM/MinFEMFlow.jl/actions/workflows/test.yml/badge.svg
