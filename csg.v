module lorenz_chaos(
    input wire clk,              // Clock signal
    input wire reset,            // Reset signal
    input wire [31:0] sigma,     // Lorenz system parameter s
    input wire [31:0] rho,       // Lorenz system parameter ?
    input wire [31:0] beta,      // Lorenz system parameter ß
    output reg [31:0] x_out,     // Chaotic sequence x
    output reg [31:0] y_out,     // Chaotic sequence y
    output reg [31:0] z_out      // Chaotic sequence z
);
    // Internal registers for state variables
    reg [31:0] x, y, z;

    // Lorenz system dynamics
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset state to initial conditions
            x <= 32'h3F800000; // Initialize x to 1.0
            y <= 32'h3F800000; // Initialize y to 1.0
            z <= 32'h3F800000; // Initialize z to 1.0
        end else begin
            // Update Lorenz system state using Euler integration
            x <= x + ((sigma * (y - x)) >>> 16);  // dx/dt
            y <= y + (((x * (rho - z)) - y) >>> 16); // dy/dt
            z <= z + (((x * y) - (beta * z)) >>> 16); // dz/dt
        end
    end

    // Update outputs (assign outputs to state variables)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            x_out <= 32'b0;
            y_out <= 32'b0;
            z_out <= 32'b0;
        end else begin
            x_out <= x;
            y_out <= y;
            z_out <= z;
        end
    end
endmodule
