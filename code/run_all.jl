# Runs every verification script's main function in order and prints results.
# Usage:  julia --project=. code/run_all.jl

include(joinpath(@__DIR__, "00_elementary_examples.jl"))
include(joinpath(@__DIR__, "01_theorem1.jl"))
include(joinpath(@__DIR__, "02_theorem2.jl"))
include(joinpath(@__DIR__, "03_theorem3.jl"))
include(joinpath(@__DIR__, "04_theorem4.jl"))
include(joinpath(@__DIR__, "05_theorem5.jl"))
include(joinpath(@__DIR__, "06_theorem6.jl"))

println("\n=== Example 1 (Z/8Z) ==="); annihilators_of_Zn(8)
println("\n=== Example 2 (Z/5Z) ==="); annihilators_of_Zn(5)
println("\n=== Example 3 (Z/25Z) ==="); annihilators_of_Zn(25)

println("\n=== Theorem 1 ==="); println(verify_theorem1())
println("\n=== Theorem 2 ==="); println(verify_theorem2())
println("\n=== Theorem 3 ==="); println(verify_theorem3())
println("\n=== Theorem 4 ==="); println(verify_theorem4())
println("\n=== Theorem 5 ==="); println(verify_theorem5())
println("\n=== Theorem 6 ==="); println(verify_theorem6())
