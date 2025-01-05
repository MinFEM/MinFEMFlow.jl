using MinFEMFlow, MinFEM

function example()   
    # Setup domain
    mesh::Mesh = import_mesh("meshes/3D-channel-1.msh")
    noSlipBoundary = select_boundaries(mesh, 10001, 10002, 10003, 10005, 10006)
    inflowBoundary = select_boundaries(mesh, 10006)

    # Setup inflow
    inflow(x) = [cos(pi*abs(x[2])/6)*cos(pi*abs(x[3])/6), 0.0, 0.0]

    # Setup and solve flow problem
    flow = StokesFlowSolver(mesh, inflowBoundary, noSlipBoundary, inflow)
    solve!(flow)
    write_to_vtk(flow, "results/3D-channel") 
end

example()
