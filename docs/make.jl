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

makedocs(
    modules = [MinFEMFlow],
    sitename = "MinFEMFlow.jl",
    authors = "Martin Siebenborn, Henrik Wyschka",
    format = FORMAT,
    pages = PAGES,
    remotes = nothing
)

#deploydocs(
#    repo = "github.com/MinFEM/MinFEMFlow.jl.git"
#)
