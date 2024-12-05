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
    println("saved to $filename")
end

function vary_R()
    println("Enter initial sugar amount Q0(g) (e.g., 50):")
    Q0 = parse(Float64, readline())
    println("Enter inflow sugar concentration X(g/L) (e.g., 0.25):")
    X = parse(Float64, readline())
    println("Enter flow rates R(L/min) (e.g., 1,2,3,4,5):")
    Rs = parse.(Float64, split(readline(), ","))
    tspan = (0.0, 60.0)
    filename = "GoalA.png"
    draw(Q0, X, Rs, tspan, filename)
end

vary_R()
