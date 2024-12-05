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
    println("saved to $filename")
end

function vary_Q0()
    println("Enter initial sugar quantities Q0(g) (e.g., 50,45,40):")
    Q0s = parse.(Float64, split(readline(), ","))
    println("Enter inflow sugar concentration X(g/L) (e.g., 0.25):")
    X = parse(Float64, readline())
    println("Enter flow rate R(L/min) (e.g., 5):")
    R = parse(Float64, readline())
    tspan = (0.0, 60.0)
    filename = "GoalB.png"
    draw(Q0s, X, R, tspan, filename)
end

vary_Q0()
