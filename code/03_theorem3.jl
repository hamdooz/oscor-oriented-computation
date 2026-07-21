# Verification of Theorem 3 (necessity of a singleton Ass(M))
# Pekin & Ozkaya, Algebra and Discrete Mathematics 41(2), 235-243 (2026)

using Oscar

"""
    verify_theorem3() -> NamedTuple

Builds M = R/p1 (+) R/p2 with p1, p2 of unequal Krull dimension, and
checks that M fails to be totally annihilator-dependent (contrapositive
of Theorem 3), i.e. dim R/Ann(N1+N2) = max(d1,d2) != min(d1,d2).
"""
function verify_theorem3()
    R, (x, y) = polynomial_ring(QQ, [:x, :y])

    p1 = ideal(R, [x])
    p2 = ideal(R, [x - 1, y])

    F1 = free_module(R, 1)
    N1_alone = SubquoModule(F1, R[one(R);], R[x;])
    F2 = free_module(R, 1)
    N2_alone = SubquoModule(F2, R[one(R);], R[x-1; y])

    M, incs = direct_sum(N1_alone, N2_alone)
    N1, _ = image(incs[1])
    N2, _ = image(incs[2])

    J1   = annihilator(N1)
    J2   = annihilator(N2)
    Jsum = annihilator(N1 + N2)

    A1,   _ = quo(R, J1)
    A2,   _ = quo(R, J2)
    Asum, _ = quo(R, Jsum)

    d1, d2, dsum = dim(A1), dim(A2), dim(Asum)

    hypothesis_holds     = (d1 != d2)
    equals_max           = (dsum == max(d1, d2))
    total_dependence_fails = !(dsum == min(d1, d2))

    return (
        d1 = d1, d2 = d2, dsum = dsum,
        hypothesis_holds       = hypothesis_holds,
        equals_max              = equals_max,
        total_dependence_fails  = total_dependence_fails,
    )
end

if abspath(PROGRAM_FILE) == @__FILE__
    r = verify_theorem3()
    println(r)
end
