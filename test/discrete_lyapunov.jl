using DynamicalSystems, Base.Test

@testset "Discrete Lyapunovs" begin
  @testset "Towel Map" begin
    @testset "λspectrum" begin
      ds = DynamicalSystems.Systems.towel()
      λ1 = λspectrum(ds, 1e6)
      @test 0.42 < λ1[1] < 0.44
      @test 0.36 < λ1[2] < 0.38
      @test -3.4 < λ1[3] < -3.2
    end

    @testset "λspectrum ForwardDiff" begin
      ds = DynamicalSystems.Systems.towel()
      ds = DiscreteDS(ds.state, ds.eom)
      λ1 = λspectrum(ds, 1e6)
      @test 0.42 < λ1[1] < 0.44
      @test 0.36 < λ1[2] < 0.38
      @test -3.4 < λ1[3] < -3.1
    end

    @testset "λmax" begin
      ds1 = DynamicalSystems.Systems.towel()
      ds2 = DiscreteDS(ds1.state, ds1.eom)
      λ1 = λmax(ds1, 1000000)
      λ2 = λmax(ds2, 1000000)
      @test 0.42 < λ1[1] < 0.44
      @test 0.42 < λ2[1] < 0.44
      @test isapprox(λ1, λ2; rtol = 1e-4)
    end
  end

  @testset "Logistic Map" begin
    lg1 = DynamicalSystems.Systems.logistic()
    lg2 = DiscreteDS1D(lg1.state, lg1.eom)
    λ1 = λmax(lg1, 100000000; Ntr = 100)
    λ2 = λspectrum(lg2, 100000000; Ntr = 100)
    @test isapprox(λ1, log(2); rtol = 1e-4)
    @test isapprox(λ2, log(2); rtol = 1e-4)
    @test isapprox(λ1, λ2; rtol = 1e-4)
  end

  @testset "Henon Map" begin
    @testset "λspectrum" begin
      ds = DynamicalSystems.Systems.henon()
      λ1 = λspectrum(ds, 1e6)
      @test 0.418 < λ1[1] < 0.422
      @test -1.63 < λ1[2] < -1.61
    end

    @testset "λspectrum ForwardDiff" begin
      ds = DynamicalSystems.Systems.henon()
      ds = DiscreteDS(ds.state, ds.eom)
      λ1 = λspectrum(ds, 1e6)
      @test 0.418 < λ1[1] < 0.422
      @test -1.63 < λ1[2] < -1.61
    end

    @testset "λmax" begin
      ds1 = DynamicalSystems.Systems.henon()
      ds2 = DiscreteDS(ds1.state, ds1.eom)
      λ1 = λmax(ds1, 1000000)
      λ2 = λmax(ds2, 1000000)
      @test 0.418 < λ1[1] < 0.422
      @test 0.418 < λ2[1] < 0.422
      @test isapprox(λ1, λ2; rtol = 1e-6)
    end
  end

end