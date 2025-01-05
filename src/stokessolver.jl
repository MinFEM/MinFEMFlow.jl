"""
    StokesFlowSolver(
        mesh::Mesh,
        inflow_boundary::Union{Set{Boundary}, Set{Int64}},
        noslip_boundary::Union{Set{Boundary}, Set{Int64}},
        inflow::Union{Vector{Float64}, Function};
        verbose::Bool = true
    ) -> FlowSolver

Returns FlowSolver object representing the solution routine for a Stokes flow.
"""
function StokesFlowSolver(
    mesh::Mesh,
    inflow_boundary::Union{Set{Boundary}, Set{Int64}},
    noslip_boundary::Union{Set{Boundary}, Set{Int64}},
    inflow::Union{Vector{Float64}, Function};
    verbose::Bool = true
)
    _inflow_boundary = inflow_boundary isa Set{Boundary} ? 
        extract_nodes(inflow_boundary) : inflow_boundary

    _noslip_boundary = noslip_boundary isa Set{Boundary} ? 
        extract_nodes(noslip_boundary) : noslip_boundary

    _inflow = inflow isa Function ?
        evaluate_mesh_function(mesh, inflow, region=_inflow_boundary, qdim=mesh.d) : inflow

    return FlowSolver(
        mesh,
        _inflow_boundary,
        _noslip_boundary,
        _inflow,
        verbose,
        solve_stokesflow!,
        missing,
        missing,
        missing
    )
end

"""
$(TYPEDSIGNATURES)

Returns solution of Stokes flow [u,p] given on given mesh as vector. 
The inlet velocity function f is applied to the inflow_boundary,
which has to be a part of the boundary. 
On the rest of this boundary no-slip conditions will be applied.
Note that the outflow boundary is not given since it is designed to be a free boundary.
"""
function solve_stokesflow!(fs::FlowSolver)
    output_header(fs.verbose)

    tsetup = @elapsed dim = fs.mesh.d 
    tsetup += @elapsed n = fs.mesh.nnodes
    tsetup += @elapsed A = assemble_saddlepointmatrix_stokes(fs.mesh)
    tsetup += @elapsed rhs = zeros((dim+1)*n)

    tsetup += @elapsed assemble_dirichletcondition!(
        A,
        union(fs.inflow_boundary, fs.noslip_boundary),
        rhs = rhs,
        bc = fs.inflow,
        qdim = dim
    )
    
    output_setup(fs.verbose, tsetup)

    tsolve = @elapsed x = A\rhs

    set_result!(fs, x[1:dim*n], x[dim*n+1:end], tsetup+tsolve)

    output_end(fs.verbose, tsetup, tsolve)
end

"""
$(TYPEDSIGNATURES)

Returns saddle point system matrix including inf-sup stabilization
for the solution of the discretized Stokes equation. 
"""
function assemble_saddlepointmatrix_stokes(mesh::Mesh; alpha::Float64=0.05)
    L = assemble_laplacian(mesh, qdim=mesh.d)
    B = assemble_incompressibility_stokes(mesh)
    C = assemble_stabilization_stokes(mesh)

    return [L B; B' -alpha*C]
end

"""
$(TYPEDSIGNATURES)

Returns the matrix for a linear incompressibility block in the saddle point system 
for the discretized Stokes equation.
"""
function assemble_incompressibility_stokes(mesh::Mesh)

    AA = zeros(Float64, mesh.nelems * (mesh.d+1)^2 * mesh.d)
    II = zeros(Int64, length(AA))
    JJ = zeros(Int64, length(AA))
    n = 0
    midpoint = quadrature_points(mesh.d,1)[1]

    for el = 1:mesh.nelems
        nodes = mesh.Elements[el]
        l = length(nodes)
        (detJ, J) = jacobian(mesh, nodes)
        elemMat = zeros(mesh.d*l,l)
        for i = 1:l
            for j = 1:l
                temp = phi(j, midpoint) * 
                    (J*grad_phi(mesh.d,i))  * 
                    detJ / factorial(mesh.d)
                for r = 1:mesh.d
                    elemMat[mesh.d*(i-1)+r,j] += temp[r]
                end
            end
        end

        for d = 1:mesh.d
            for i = 1:l
                for j = 1:l
                    n = n+1
                    II[n] = mesh.d * (nodes[i]-1) + d
                    JJ[n] = nodes[j]
                    AA[n] = elemMat[mesh.d*(i-1) + d, j]
                end
            end
        end
    end

    return sparse(II[1:n], JJ[1:n], AA[1:n])
end

"""
$(TYPEDSIGNATURES)

Returns stabilization matrix for saddle point system in the Stokes equation.
"""
function assemble_stabilization_stokes(mesh::Mesh)

    AA = zeros(Float64, mesh.nelems * (mesh.d+1)^2)
    II = zeros(Int64, length(AA))
    JJ = zeros(Int64, length(AA))
    n = 0
    diam = elementdiameter(mesh)

    for el = 1:mesh.nelems
        nodes = mesh.Elements[el]
        l = length(nodes)
        (detJ, J) = jacobian(mesh, nodes)
        elemMat = zeros(l, l)
        h = diam[el] / sqrt(mesh.d)
        for i = 1:l
            T = J*grad_phi(mesh.d, i)
            for j=1:l
                elemMat[i,j] += h^2 * (T' * (J*grad_phi(mesh.d, j)))[1,1]
            end
        end
        elemMat *= detJ / factorial(mesh.d)

        for i = 1:l
            for j = 1:l
                n = n+1
                II[n] = nodes[i]
                JJ[n] = nodes[j]
                AA[n] = elemMat[i,j]
            end
        end
    end

    return sparse(II[1:n], JJ[1:n], AA[1:n])
end

"""
$(TYPEDSIGNATURES)

Prints a vertical line of width corresponding to the log.
"""
function print_line()
    println("⧆" * repeat("=",38) * "⧆")
end

"""
$(TYPEDSIGNATURES)

Writes header to console if Stokes solver is verbose.
"""
function output_header(verbose::Bool)
    !verbose && return

    print_line()
    println("‖" * rpad(" Stokes Flow Solver", 38) * "‖")
    print_line() 
end

"""
$(TYPEDSIGNATURES)

Writes setup time to console if Stokes solver is verbose.
"""
function output_setup(verbose::Bool, tsetup::Float64)
    !verbose && return

    st = @sprintf("%.03f", tsetup)
    println("‖" * rpad(" Setup", 10) * "| " * rpad("$(st) s", 26) * "‖")
end

"""
$(TYPEDSIGNATURES)

Writes computation time and summary to console if Stokes solver is verbose.
"""
function output_end(verbose::Bool, tsetup::Float64, tsol::Float64)
    !verbose && return

    st1 = @sprintf("%.03f", tsol)
    st2 = @sprintf("%.03f", tsetup+tsol)
    println("‖" * rpad(" Solution", 10) * "| " * rpad("$(st1) s", 26) * "‖")
    println("‖" * rpad(" Complete", 10) * "| " * rpad("$(st2) s", 26) * "‖")
    print_line()
end
