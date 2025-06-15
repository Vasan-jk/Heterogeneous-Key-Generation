module heterogeneous_key_gen(
    input wire [31:0] r,         
    input wire [31:0] s,         
    input wire [31:0] p,         
    input wire clk,              
    input wire reset,            
    output wire [31:0] key1,     
    output wire [31:0] key2      
);

    
    wire [31:0] log_key1, log_key2;
    wire [31:0] chaos_x, chaos_y, chaos_z;

    
    log_key_gen log1 (.input_val(r), .base(p), .log_key(log_key1));
    log_key_gen log2 (.input_val(s), .base(p), .log_key(log_key2));

    
    lorenz_chaos chaos_gen (
        .clk(clk),
        .reset(reset),
        .sigma(32'hA0000000),  // s = 10.0
        .rho(32'h1C000000),    // ? = 28.0
        .beta(32'h2AAAAB),     // ß = 8/3
        .x_out(chaos_x),
        .y_out(chaos_y),
        .z_out(chaos_z)
    );

    
    key_combiner combiner (
        .log_key1(log_key1),
        .log_key2(log_key2),
        .chaos_x(chaos_x),
        .chaos_y(chaos_y),
        .final_key1(key1),
        .final_key2(key2)
    );

endmodule
