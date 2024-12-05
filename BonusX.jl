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
        plot!(sol.t, [u[1] for u in sol.u], label="X(g/L) = $X", lw=1)
    end
    savefig(plt, filename)
    println("saved to $filename")
end

function vary_X()
    println("Enter initial sugar amount Q0(g) (e.g., 50):")
    Q0 = parse(Float64, readline())
    println("Enter flow rate R(L/min) (e.g., 5):")
    R = parse(Float64, readline())
    println("Enter inflow sugar concentrations X(g/L) (e.g., 5,4.5,4,3.5):")
    Xs = parse.(Float64, split(readline(), ","))
    tspan = (0.0, 60.0)
    filename = "GoalC.png"
    draw(Q0, Xs, R, tspan, filename)
end

vary_X()
