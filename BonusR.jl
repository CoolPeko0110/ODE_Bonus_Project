using DifferentialEquations
using Plots

# Define the rate of change of sugar quantity
function sugar_dynamics!(du, u, p, t)
    R, X = p
    du[1] = R * X - R * (u[1] / 100)  # dQ/dt = R*X - R*(Q/100)
end

# Analyze dynamics for varying R and save plot
function analyze_varying_R_and_save(Q0, X, Rs, tspan, filename)
    plt = plot(title="Impact of Varying R on Sugar Dynamics",
               xlabel="Time (minutes)", ylabel="Sugar Quantity (g)", legend=:topright)
    for R in Rs
        u0 = [Q0]  # Initial condition
        prob = ODEProblem(sugar_dynamics!, u0, tspan, (R, X))
        sol = solve(prob)
        plot!(sol.t, [u[1] for u in sol.u], label="R = $R", lw=2)  # Extract Q values
    end
    savefig(plt, filename)  # Save plot to file
    println("Plot saved to $filename")
end

# Main function for Goal A
function vary_R()
    # User-defined parameters
    Q0 = 50              # Initial sugar amount in grams
    X = 1                # Inflow sugar concentration in g/L
    Rs = [1, 2, 3, 4, 5] # Flow rates in L/min
    tspan = (0.0, 60.0)  # Time range in minutes

    # File name to save the plot
    filename = "goalA_varying_R_plot.png"

    # Analyze and save plot
    analyze_varying_R_and_save(Q0, X, Rs, tspan, filename)
end

# Run the main function
vary_R()
