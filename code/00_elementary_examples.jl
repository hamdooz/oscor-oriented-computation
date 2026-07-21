# Elementary examples over Z (Examples 1-3 of the original paper).
# No OSCAR dependency needed -- pure integer arithmetic.

"""
    annihilators_of_Zn(n) -> Vector{Int}

Print and return Ann(m-bar) (as the positive generator a with Ann = aZ)
for every nonzero m in Z/nZ.
"""
function annihilators_of_Zn(n::Int)
    println("--- M = Z/$(n)Z ---")
    result = Int[]
    for m in 1:(n-1)
        a = div(n, gcd(m, n))
        println("Ann($(m)-bar) = ($(a))Z")
        push!(result, a)
    end
    return result
end

"""
    verify_example1() -> Bool

Checks the annihilators claimed in Example 1 of the original paper for
M = Z/8Z: Ann(1)=Ann(3)=Ann(5)=Ann(7)=8Z, Ann(2)=Ann(6)=4Z, Ann(4)=2Z.
"""
function verify_example1()
    anns = annihilators_of_Zn(8)
    expected = Dict(1=>8, 2=>4, 3=>8, 4=>2, 5=>8, 6=>4, 7=>8)
    all(anns[m] == expected[m] for m in 1:7)
end

"""
    verify_example3() -> Bool

Checks Example 3 (M = Z/25Z): every nonzero submodule has annihilator
a power of 5, consistent with Ass(M) = {5Z}.
"""
function verify_example3()
    anns = annihilators_of_Zn(25)
    all(a % 5 == 0 for a in anns)
end

if abspath(PROGRAM_FILE) == @__FILE__
    annihilators_of_Zn(8)
    annihilators_of_Zn(5)
    annihilators_of_Zn(25)
end
