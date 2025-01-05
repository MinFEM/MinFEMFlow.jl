using MinFEMFlow, MinFEM

function example()   
    # Setup domain
    mesh::Mesh = import_mesh("meshes/u-channel-4.msh");
    noSlipBoundary = select_boundaries(mesh, 1001, 1003, 1004)
    inflowBoundary = select_boundaries(mesh, 1001)

    # Setup inflow
    inflow(x) = [0.0, cos(pi*abs(x[1]+3)/2)]

    # Setup and solve flow problem
    flow = StokesFlowSolver(mesh, inflowBoundary, noSlipBoundary, inflow)
    solve!(flow)
    write_to_vtk(flow, "results/u-channel") 
end

example()
