using MinFEM, MinFEMFlow

function test3d()
    mesh = import_mesh("test-channel3.msh");
    noslip_boundary = select_boundaries(mesh, 10001, 10002, 10003, 10005, 10006)
    inflow_boundary = select_boundaries(mesh, 10006)
    inflow(x) = [cos(pi*abs(x[2])/6)*cos(pi*abs(x[3])/6), 0.0, 0.0]

    flow = StokesFlowSolver(mesh, inflow_boundary, noslip_boundary, inflow, verbose=false)
    solve!(flow)
    
    ismissing(flow.time) && return false

    return true
end

@test test3d()
