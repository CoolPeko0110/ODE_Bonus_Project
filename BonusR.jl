using DifferentialEquations
using Plots

function formulas!(du, u, p, t)
    R, X = p
    du[1] = R * X - R * (u[1] / 100)
end

function draw(Q0, X, Rs, tspan, filename)
    plt = plot(title="Sugar Dynamics, Fixing X And Q0, Varying R",
               xlabel="Time (minutes)", ylabel="Amount of Sugar (g)", legend=:topright)
    for R in Rs
        u0 = [Q0]
        prob = ODEProblem(formulas!, u0, tspan, (R, X))
        sol = solve(prob, saveat=0.01)
        plot!(sol.t, [u[1] for u in sol.u], label="R(L) = $R", lw=1)
    end
    savefig(plt, filename)
end

function vary_R()
    Q0 = 50
    X = 0.25
    Rs = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    tspan = (0.0, 60.0)
    draw(Q0, X, Rs, tspan, "GoalA.png")
end

vary_R()
