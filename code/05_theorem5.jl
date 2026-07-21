# Verification of Theorem 5 (radical sum equivalence)
# Pekin & Ozkaya, Algebra and Discrete Mathematics 41(2), 235-243 (2026)
#
# Direction (i) => (ii) is already witnessed by the p1 != p2 case in
# 01_theorem1.jl (a single failing pair suffices to falsify the
# universal statement (i) whenever Ass(M) is not a singleton).
#
# Direction (ii) => (i) is tested here on M = R/(x^2), Ass(M) = {(x)},
# across four structurally distinct pairs of cyclic submodules.

using Oscar

"""
    verify_theorem5() -> Vector{Bool}

Returns, for each of four structurally distinct pairs of submodules of
M = R/(x^2), whether sqrt(Ann(N1+N2)) == sqrt(Ann(N1)) + sqrt(Ann(N2)).
"""
function verify_theorem5()
    R, (x, y) = polynomial_ring(QQ, [:x, :y])
    I = ideal(R, [x^2])

    F = free_module(R, 1)
    Mmod = SubquoModule(F, R[one(R);], R[x^2;])
    g = gens(Mmod)[1]

    pairs = [
        (x*g, y*g),
        (y*g, (x+y)*g),
        ((2*x+3*y)*g, (x-y)*g),
        (x*g, (x+y)*g),
    ]

    results = Bool[]
    for (a, b) in pairs
        Na, _ = sub(Mmod, [a])
        Nb, _ = sub(Mmod, [b])
        Ja   = annihilator(Na)
        Jb   = annihilator(Nb)
        Jsum = annihilator(Na + Nb)
        lhs = radical(Jsum)
        rhs = radical(Ja) + radical(Jb)
        push!(results, lhs == rhs)
    end
    return results
end

if abspath(PROGRAM_FILE) == @__FILE__
    r = verify_theorem5()
    for (i, ok) in enumerate(r)
        println("Pair $i holds? ", ok)
    end
end
