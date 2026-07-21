# Test suite for the computational verifications accompanying
# "A Computational Verification of Annihilator-Based Radical Dependency
# via OSCAR" (Hamdullah Ozkaya).
#
# Requirements to run: Julia >= 1.10 and OSCAR.jl (see ../Project.toml).
# From the repository root:
#
#   julia --project=. -e 'using Pkg; Pkg.instantiate()'
#   julia --project=. test/runtests.jl
#
# Scripts 00 and 06 use only base Julia integer arithmetic; scripts
# 01-05 require OSCAR and will take noticeably longer on first run
# (Julia/OSCAR precompilation).

using Test

const CODE_DIR = joinpath(@__DIR__, "..", "code")

include(joinpath(CODE_DIR, "00_elementary_examples.jl"))
include(joinpath(CODE_DIR, "01_theorem1.jl"))
include(joinpath(CODE_DIR, "02_theorem2.jl"))
include(joinpath(CODE_DIR, "03_theorem3.jl"))
include(joinpath(CODE_DIR, "04_theorem4.jl"))
include(joinpath(CODE_DIR, "05_theorem5.jl"))
include(joinpath(CODE_DIR, "06_theorem6.jl"))

@testset "Elementary examples over Z (Examples 1 and 3)" begin
    @test verify_example1()
    @test verify_example3()
end

@testset "Theorem 1: characterization of radical dependence" begin
    r = verify_theorem1()
    @test r.case1_rad_J1_correct
    @test r.case1_rad_J2_correct
    @test r.case1_intersection_ok
    @test r.case1_sum_fails    # p1 != p2  => radical dependence must fail
    @test r.case2_sum_holds    # p1 == p2  => radical dependence must hold
end

@testset "Theorem 2: total annihilator-dependence" begin
    r = verify_theorem2()
    @test r.ass_is_singleton
    @test r.annihilators_differ   # J1 != J2, so the equality is not a tautology
    @test r.theorem2_holds
end

@testset "Theorem 3: necessity of a singleton Ass(M)" begin
    r = verify_theorem3()
    @test r.hypothesis_holds          # d1 != d2
    @test r.equals_max                # dim R/(p1 cap p2) = max(d1,d2)
    @test r.total_dependence_fails    # hence M is not totally annihilator-dependent
end

@testset "Theorem 4: Radical Distinction Set" begin
    r = verify_theorem4()
    @test r.ann_rad_is_zero
    @test r.theorem4_holds
end

@testset "Theorem 5: radical sum equivalence (direction (ii) => (i))" begin
    results = verify_theorem5()
    @test length(results) == 4
    @test all(results)
end

@testset "Theorem 6: multiplication modules (Z/25Z submodule lattice)" begin
    results = verify_theorem6()
    @test length(results) == 4
    @test all(results)
end
