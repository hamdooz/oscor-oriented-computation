# Verification of Theorem 1 (characterization of radical dependence)
# Pekin & Ozkaya, Algebra and Discrete Mathematics 41(2), 235-243 (2026)

using Oscar

"""
    verify_theorem1() -> NamedTuple

Builds the p1 != p2 and p1 == p2 cases used in the note and returns the
key booleans as a named tuple for testing.
"""
function verify_theorem1()
    R, (x, y) = polynomial_ring(QQ, [:x, :y])

    # --- Case p1 != p2 ---
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

    rad_J1   = radical(J1)
    rad_J2   = radical(J2)
    rad_Jsum = radical(Jsum)

    case1_rad_J1_correct   = (rad_J1 == p1)
    case1_rad_J2_correct   = (rad_J2 == p2)
    case1_intersection_ok  = (rad_Jsum == intersect(rad_J1, rad_J2))
    case1_sum_fails        = !(rad_Jsum == rad_J1 + rad_J2)  # expected: dependence fails

    # --- Case p1 == p2 ---
    p1b = ideal(R, [x])
    p2b = ideal(R, [x])

    F1b = free_module(R, 1)
    N1_aloneb = SubquoModule(F1b, R[one(R);], R[x;])
    F2b = free_module(R, 1)
    N2_aloneb = SubquoModule(F2b, R[one(R);], R[x;])

    Mb, incsb = direct_sum(N1_aloneb, N2_aloneb)
    N1b, _ = image(incsb[1])
    N2b, _ = image(incsb[2])

    J1b = annihilator(N1b); J2b = annihilator(N2b); Jsumb = annihilator(N1b + N2b)
    rad_J1b = radical(J1b); rad_J2b = radical(J2b); rad_Jsumb = radical(Jsumb)

    case2_sum_holds = (rad_Jsumb == rad_J1b + rad_J2b)  # expected: dependence holds

    return (
        case1_rad_J1_correct  = case1_rad_J1_correct,
        case1_rad_J2_correct  = case1_rad_J2_correct,
        case1_intersection_ok = case1_intersection_ok,
        case1_sum_fails       = case1_sum_fails,
        case2_sum_holds       = case2_sum_holds,
    )
end

if abspath(PROGRAM_FILE) == @__FILE__
    r = verify_theorem1()
    println(r)
end
