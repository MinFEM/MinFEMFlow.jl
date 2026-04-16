using Documenter, MinFEMFlow

Home = "Home" => "index.md"

Examples = "examples.md"

Library = "library.md"

License = "license.md"

PAGES = [
    Home,
    Examples,
    Library,
    License
]

FORMAT = Documenter.HTML(
    prettyurls = true,
    assets = ["assets/favicon.ico"]
)

REMOTES = Dict(
    "MinFEM" => Documenter.Remotes.GitHub("MinFEM", "MinFEM.jl"),
    "MinFEMFlow"=> Documenter.Remotes.GitHub("MinFEM", "MinFEMFlow.jl")
)

makedocs(
    modules = [MinFEMFlow],
    sitename = "MinFEMFlow.jl",
    authors = "Martin Siebenborn, Henrik Wyschka",
    format = FORMAT,
    pages = PAGES,
    remotes = REMOTES
)

deploydocs(
    repo = "github.com/MinFEM/MinFEMFlow.jl.git"
)
