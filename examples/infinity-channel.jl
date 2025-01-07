using MinFEMFlow, MinFEM

function example()   
    # Setup domain
    mesh::Mesh = import_mesh("meshes/infinity-channel-4.msh");
    noslip_boundary = select_boundaries(mesh, 1003, 1004)
    inflow_boundary = select_boundaries(mesh, 1001)

    # Setup inflow
    inflow(x) = [1-(2*(x[2]-1.5))^2, 0.0]

    # Setup and solve flow problem
    flow = StokesFlowSolver(mesh, inflow_boundary, noslip_boundary, inflow)
    solve!(flow)
    write_to_vtk(flow, "results/infinity-channel-4") 
end

example()
