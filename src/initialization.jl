
function parse_customers(filepath::String, delim::Char=',', agents=nothing)
    data = readdlm(filepath, delim, String, header=true)[1]
    agents = isnothing(agents) ? Dict{Int64,Union{Customer,External}}() : agents
    for row in eachrow(data)
        agents[parse(Int64, row[1])] = Customer(row[2:end]...)
    end
    return agents
end

function parse_external_entities(filepath::String, delim::Char=',', agents=nothing)
    data = readdlm(filepath, delim, Any, header=true)[1]
    agents = isnothing(agents) ? Dict{Int64,Union{Customer,External}}() : agents
    for row in eachrow(data)
        agents[row[1]] = External(row[2:end]...)
    end
    return agents
end

function parse_transaction_graph(agents::Dict{Int64,Union{Customer,External}}, filepath::String, delim::Char=',')
    data = readdlm(filepath, delim, Int, header=true)[1]
    graph = MetaGraph(
        Graph();
        Label=Symbol,
        VertexData=Union{Customer,External},
        EdgeData=NTuple{4,Int64},
        graph_data="transaction_network"
    )

    #Nodes attributes
    for node in 1:maximum(data[:, [1, 2]])
        graph[Symbol(node)] = agents[node]
    end

    #Edges attributes
    for row in eachrow(data)
        graph[Symbol(row[1]), Symbol(row[2])] = Tuple(row[3:end])
    end
    return graph
end


function parse_aml_rules(filepath::String, delim::Char=',')
    data = readdlm(filepath, delim, Any, header=true)[1]
    return [Scenario(row...) for row in eachrow(data)]
end

function parse_malicious_customers_list()

end

