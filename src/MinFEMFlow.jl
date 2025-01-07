"""
MinFEMFlow

A minimalistic Stokes flow solver in julia based on MinFEM.
"""
module MinFEMFlow

using MinFEM
using LinearAlgebra, SparseArrays, Printf
using DocStringExtensions

import MinFEM: write_to_vtk, solve!

include("flowsolver.jl")
include("stokessolver.jl")

export  FlowSolver

export  invalidate!,
        set_mesh!,
        set_boundary_inflow!,
        set_boundary_noslip!,
        set_inflow!,
        set_verbose!,
        set_result!,
        copy_result!,
        solve!,
        write_to_vtk

export  StokesFlowSolver,
        assemble_saddlepointmatrix_stokes


end # module
