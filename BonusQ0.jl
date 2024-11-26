using DifferentialEquations
using Plots

function formulas!(du, u, p, t)
    R, X = p
    du[1] = R * X - R * (u[1] / 100)
end

function draw(Q0s, X, R, tspan, filename)
    plt = plot(title="Sugar Dynamics, Fixing X And R, Varying Q0",
               xlabel="Time (minutes)", ylabel="Amount of Sugar (g)", legend=:topright)
    for Q0 in Q0s
        u0 = [Q0]
        prob = ODEProblem(formulas!, u0, tspan, (R, X))
        sol = solve(prob, saveat=0.01)
        plot!(sol.t, [u[1] for u in sol.u], label="Q0(g) = $Q0", lw=1)
    end
    savefig(plt, filename)
end

function vary_Q0()
    Q0s = [50, 45, 40, 35, 30, 25, 20, 15, 10, 5, 0]
    X = 0.25
    R = 5
    tspan = (0.0, 60.0)
    draw(Q0s, X, R, tspan, "GoalB.png")
end

vary_Q0()
