using SimLAMoN
using DelimitedFiles
using MetaGraphsNext

#Initialization
agents = parse_customers("examples/customers.csv")
agents = parse_external_entities("examples/external_entities.csv",',',agents)
graph = parse_transaction_graph(agents, "examples/graph.csv")
central_auth = Authority(400, parse_aml_rules("examples/rules.csv"))

#Run simulation
simulate(graph, central_auth)
#gather stats