using MinFEMFlow, MinFEM

function example()   
    # Setup domain
    mesh::Mesh = import_mesh("meshes/l-channel-4.msh");
    noSlipBoundary = select_boundaries(mesh, 1001, 1003, 1004)
    inflowBoundary = select_boundaries(mesh, 1001)

    # Setup inflow
    inflow(x) = [cos(pi*abs(x[2]+1)/2), 0.0]

    # Setup and solve flow problem
    flow = StokesFlowSolver(mesh, inflowBoundary, noSlipBoundary, inflow)
    solve!(flow)
    write_to_vtk(flow, "results/l-channel") 
end

example()
