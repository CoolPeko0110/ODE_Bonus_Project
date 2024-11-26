using DifferentialEquations
using Plots

# Define the rate of change of sugar quantity
function sugar_dynamics!(du, u, p, t)
    R, X = p
    du[1] = R * X - R * (u[1] / 100)  # dQ/dt = R*X - R*(Q/100)
end

# Analyze dynamics for varying X and save plot
function analyze_varying_X_and_save(Q0, Xs, R, tspan, filename)
    plt = plot(title="Impact of Varying X on Sugar Dynamics",
               xlabel="Time (minutes)", ylabel="Sugar Quantity (g)", legend=:topright)
    for X in Xs
        u0 = [Q0]  # Initial condition
        prob = ODEProblem(sugar_dynamics!, u0, tspan, (R, X))
        sol = solve(prob)
        plot!(sol.t, [u[1] for u in sol.u], label="X = $X", lw=2)  # Extract Q values
    end
    savefig(plt, filename)  # Save plot to file
    println("Plot saved to $filename")
end

# Main function for Goal C
function vary_X()
    # User-defined parameters
    Q0 = 50              # Initial sugar amount in grams
    Xs = [0.5, 1, 1.5, 2] # Different inflow sugar concentrations in g/L
    R = 2                # Flow rate in L/min
    tspan = (0.0, 60.0)  # Time range in minutes

    # File name to save the plot
    filename = "goalC_varying_X_plot.png"

    # Analyze and save plot
    analyze_varying_X_and_save(Q0, Xs, R, tspan, filename)
end

# Run the main function
vary_X()
