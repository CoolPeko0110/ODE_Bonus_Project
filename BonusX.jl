using DifferentialEquations
using Plots

function formulas!(du, u, p, t)
    R, X = p
    du[1] = R * X - R * (u[1] / 100)
end

function draw(Q0, Xs, R, tspan, filename)
    plt = plot(title="Sugar Dynamics, Fixing R And Q0, Varying X",
               xlabel="Time (minutes)", ylabel="Amount of Sugar (g)", legend=:topright)
    for X in Xs
        u0 = [Q0]
        prob = ODEProblem(formulas!, u0, tspan, (R, X))
        sol = solve(prob, saveat=0.01)
        plot!(sol.t, [u[1] for u in sol.u], label="X(g) = $X", lw=1)
    end
    savefig(plt, filename)
end

function vary_X()
    Q0 = 50
    Xs = [5, 4.5, 4, 3.5, 3, 2.5, 2, 1.5, 1, 0.5, 0]
    R = 5
    tspan = (0.0, 60.0)
    draw(Q0, Xs, R, tspan, "GoalC.png")
end

vary_X()
