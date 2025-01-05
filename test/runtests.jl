using MinFEM, MinFEMFlow
using Test

tests = ["test2d", "test3d"]

for t in tests
    include("$(t).jl")
end
