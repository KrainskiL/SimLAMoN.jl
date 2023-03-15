"""
`Customer` type represents regular customer of the financial institution

**Fields**

* `segment` : A business-related group agent is assigned to, i.e. SME, Private Individual
* `country` : Country of residence of agent and assumed country of an account, i.e. PL, UK, USA
* `risk`    : Risk category assigned to agent, i.e. High, Medium, Low
"""
struct Customer
    segment::String
    country::String
    risk::String
end

"""
`External` type represents external entity

**Fields**

* `type` : Category of the external entity for determining transaction type, i.e. ATM, External Account, Crypto Exchange
* `country` : Country of the external entity, i.e. PL, FR, ES
* `detection_risk`    : Risk of detection while issuing a debit (outgoing) transaction to the external entity
"""
struct External
    type::String
    country::String
    detection_risk::Float32
end

"""
`Scenario` type represents Anti-Money Laundering scenario for detection of suspicious behavior

**Fields**

* `description` : Description of the scenario
* `transaction_type` : Transaction type in scope of the scenario, i.e. Cash, Domestic
* `risk`    : Customer risk in scope of the scenario, i.e. High, All
* `segment`    : Customer segment in scope of the scenario, i.e. SME, Private Individuals
* `debit_credit`    : Direction of transactions in scope - incoming (credit) or outgoing (debit)
* `min_amount`    : Minimum aggregated amount threshold of the scenario
* `min_frequency`    : Minimum frequency threshold of the scenario
"""
struct Scenario
    description::String
    transaction_type::String
    risk::String
    segment::String
    debit_credit::String
    min_amount::Int64
    min_frequency::Int64
end

"""
`Authority` type represents central authority or financial institution monitoring the transaction network

**Fields**

* `capacity` : Number of alerts that can be processed in a single period
* `alerts` : List of customer IDs alerted in a single period
* `rules`    : Configuration of the AML rules applied to the transactional data in each period
"""
mutable struct Authority
    const capacity::Int64
    alerts::Vector{Int64}
    const rules::Vector{Scenario}
end

Authority(capacity::Int64, rules::Vector{Scenario}) = Authority(capacity,Int64[],rules)