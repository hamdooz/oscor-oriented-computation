# Verification of Theorem 2 (total annihilator-dependence)
# Pekin & Ozkaya, Algebra and Discrete Mathematics 41(2), 235-243 (2026)

using Oscar

"""
    verify_theorem2() -> NamedTuple

Constructs M = R/(x^2), confirms Ass(M) = {(x)} via primary
decomposition, and checks the total annihilator-dependence identity on
two cyclic submodules with genuinely different annihilators.
"""
function verify_theorem2()
    R, (x, y) = polynomial_ring(QQ, [:x, :y])
    I = ideal(R, [x^2])

    pd = primary_decomposition(I)
    ass_is_singleton = (length(pd) == 1) && (pd[1][2] == ideal(R, [x]))

    F = free_module(R, 1)
    Mmod = SubquoModule(F, R[one(R);], R[x^2;])
    g = gens(Mmod)[1]

    N1, _ = sub(Mmod, [x*g])
    N2, _ = sub(Mmod, [y*g])

    J1   = annihilator(N1)
    J2   = annihilator(N2)
    Jsum = annihilator(N1 + N2)

    annihilators_differ = (J1 != J2)

    A1,   _ = quo(R, J1)
    A2,   _ = quo(R, J2)
    Asum, _ = quo(R, Jsum)

    d1, d2, dsum = dim(A1), dim(A2), dim(Asum)
    theorem2_holds = (dsum == min(d1, d2))

    return (
        ass_is_singleton     = ass_is_singleton,
        annihilators_differ  = annihilators_differ,
        d1 = d1, d2 = d2, dsum = dsum,
        theorem2_holds       = theorem2_holds,
    )
end

if abspath(PROGRAM_FILE) == @__FILE__
    r = verify_theorem2()
    println(r)
end
