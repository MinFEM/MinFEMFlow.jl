using MinFEM, MinFEMFlow

function test2d()
    mesh = import_mesh("test-channel2.msh");
    noSlipBoundary = select_boundaries(mesh, 1001, 1003, 1004)
    inflowBoundary = select_boundaries(mesh, 1004)
    inflow(x) = [cos(pi*abs(x[2])/6), 0.0]

    flow = StokesFlowSolver(mesh, inflowBoundary, noSlipBoundary, inflow, verbose=false)
    solve!(flow)
    
    ismissing(flow.time) && return false

    return true
end

@test test2d()
