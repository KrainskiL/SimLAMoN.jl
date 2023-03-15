module SimLAMoN

#packages
using DelimitedFiles
using Graphs
using MetaGraphsNext

#types
export Scenario
export Authority
export Customer
export External

#initialization
export parse_customers
export parse_external_entities
export parse_transaction_graph
export parse_aml_rules

#running simulation
export simulate

include("types.jl")
include("initialization.jl")
include("simulation.jl")

end