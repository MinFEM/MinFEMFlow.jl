using MinFEMFlow, MinFEM

function example()   
    # Setup domain
    mesh::Mesh = import_mesh("meshes/cylinder-4.msh");
    noSlipBoundary = select_boundaries(mesh, 1001, 1003, 1004, 1005)
    inflowBoundary = select_boundaries(mesh, 1004)

    # Setup inflow
    box = boundingbox(mesh)
    width = box[1][2]-box[2][2]
    inflow(x) = [cos(pi*abs(x[2])/width), 0.0]

    # Setup and solve flow problem
    flow = StokesFlowSolver(mesh, inflowBoundary, noSlipBoundary, inflow)
    solve!(flow)
    write_to_vtk(flow, "results/cylinder-obstacle") 
end

example()
