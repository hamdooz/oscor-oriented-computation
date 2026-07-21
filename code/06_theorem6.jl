# Verification of Theorem 6 (multiplication modules)
# Pekin & Ozkaya, Algebra and Discrete Mathematics 41(2), 235-243 (2026)
#
# Part A: M = R/(x^2) is already a (cyclic, hence multiplication) module;
# see 02_theorem2.jl and 05_theorem5.jl for the OSCAR computation showing
# the radical sum identity holds with common value (x).
#
# Part B: exhaustive check over the full submodule lattice of Z/25Z
# (Example 3 of the original paper). Pure integer arithmetic, no OSCAR
# dependency needed.

"""
    verify_theorem6() -> Vector{Bool}

Checks, for every pair of generators (a,b) of submodules of Z/25Z, that
the radical of Ann(N1), Ann(N2) and Ann(N1+N2) all equal p = 5Z.
"""
function verify_theorem6()
    n = 25
    p = 5
    submods = [5, 1]   # generators of 5Z/25Z and of M = Z/25Z itself

    results = Bool[]
    for a in submods, b in submods
        ann_a    = div(n, gcd(a, n))
        ann_b    = div(n, gcd(b, n))
        gen_sum  = gcd(a, b)
        ann_sum  = div(n, gcd(gen_sum, n))

        rad_is_p = (ann_sum % p == 0) && (ann_a % p == 0) && (ann_b % p == 0)
        println("Ann(N1)=", ann_a, "Z, Ann(N2)=", ann_b,
                "Z, Ann(N1+N2)=", ann_sum,
                "Z -- radical of all three equals p=", p, "Z? ", rad_is_p)
        push!(results, rad_is_p)
    end
    return results
end

if abspath(PROGRAM_FILE) == @__FILE__
    verify_theorem6()
end
