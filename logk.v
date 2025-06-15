module log_key_gen(
    input wire [31:0] input_val, // Input value (r or s)
    input wire [31:0] base,      // Logarithmic base
    output reg [31:0] log_key    // Generated logarithmic key
);
    always @(input_val or base) begin
        if (input_val > 0)
            log_key = ($ln(input_val) / $ln(base)); // Fixed-point logarithm
        else
            log_key = 0;
    end
endmodule
