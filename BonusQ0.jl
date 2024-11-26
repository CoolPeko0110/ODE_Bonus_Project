using DifferentialEquations
using Plots

# Define the rate of change of sugar quantity
function sugar_dynamics!(du, u, p, t)
    R, X = p
    du[1] = R * X - R * (u[1] / 100)  # dQ/dt = R*X - R*(Q/100)
end

# Analyze dynamics for varying Q0 and save plot
function analyze_varying_Q0_and_save(Q0s, X, R, tspan, filename)
    plt = plot(title="Impact of Varying Q0 on Sugar Dynamics",
               xlabel="Time (minutes)", ylabel="Sugar Quantity (g)", legend=:topright)
    for Q0 in Q0s
        u0 = [Q0]  # Initial condition
        prob = ODEProblem(sugar_dynamics!, u0, tspan, (R, X))
        sol = solve(prob)
        plot!(sol.t, [u[1] for u in sol.u], label="Q0 = $Q0", lw=2)  # Extract Q values
    end
    savefig(plt, filename)  # Save plot to file
    println("Plot saved to $filename")
end

# Main function for Goal B
function vary_Q0()
    # User-defined parameters
    Q0s = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50]  # Different initial sugar amounts in grams
    X = 0.25                   # Inflow sugar concentration in g/L
    R = 2                   # Flow rate in L/min
    tspan = (0.0, 60.0)     # Time range in minutes

    # File name to save the plot
    filename = "goalB_varying_Q0_plot.png"

    # Analyze and save plot
    analyze_varying_Q0_and_save(Q0s, X, R, tspan, filename)
end

# Run the main function
vary_Q0()
