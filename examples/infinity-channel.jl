using MinFEMFlow, MinFEM

function example()   
    # Setup domain
    mesh::Mesh = import_mesh("meshes/infinity-4.msh");
    noSlipBoundary = select_boundaries(mesh, 1003, 1004)
    inflowBoundary = select_boundaries(mesh, 1001)

    # Setup inflow
    inflow(x) = [1-(2*(x[2]-1.5))^2, 0.0]

    # Setup and solve flow problem
    flow = StokesFlowSolver(mesh, inflowBoundary, noSlipBoundary, inflow)
    solve!(flow)
    write_to_vtk(flow, "results/infinity-channel") 
end

example()
