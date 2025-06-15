module key_combiner(
    input wire [31:0] log_key1,  // Logarithmic key 1
    input wire [31:0] log_key2,  // Logarithmic key 2
    input wire [31:0] chaos_x,   // Chaotic sequence x
    input wire [31:0] chaos_y,   // Chaotic sequence y
    output reg [31:0] final_key1, // Final key 1
    output reg [31:0] final_key2  // Final key 2
);
    always @(log_key1 or log_key2 or chaos_x or chaos_y) begin
        final_key1 = log_key1 ^ chaos_x; // Combine key 1
        final_key2 = log_key2 ^ chaos_y; // Combine key 2
    end
endmodule
