# Verification of Theorem 4 (the Radical Distinction Set)
# Pekin & Ozkaya, Algebra and Discrete Mathematics 41(2), 235-243 (2026)

using Oscar

"""
    verify_theorem4() -> NamedTuple

Localizes Q[x] at the origin to obtain a local domain R_(x), takes
M = R_(x) as a module over itself, and checks that Ann(Rad(M)) = (0)
and Ass(M) = {(0)}, confirming Theorem 4 (Zg(M) = empty by a structural
domain argument, not by enumeration).
"""
function verify_theorem4()
    R0, (x,) = polynomial_ring(QQ, [:x])
    U = complement_of_point_ideal(R0, [0])
    RL, iota = localization(R0, U)

    xL = iota(x)

    F = free_module(RL, 1)
    Nm, _ = sub(F, [xL*F[1]])
    Ann_m = annihilator(Nm)

    zero_ideal = ideal(RL, [zero(RL)])
    pd = primary_decomposition(zero_ideal)

    ann_rad_is_zero = (Ann_m == zero_ideal)
    theorem4_holds  = (length(pd) == 1) && (pd[1][2] == Ann_m)

    return (
        ann_rad_is_zero = ann_rad_is_zero,
        theorem4_holds  = theorem4_holds,
    )
end

if abspath(PROGRAM_FILE) == @__FILE__
    r = verify_theorem4()
    println(r)
end
