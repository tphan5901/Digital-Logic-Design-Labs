//combinational circuits
//nonblocking should not be used with combinational circuits

module blocking (
    input a, b, c,
    output reg x
);

    always @(a, b, c) begin
        x = a;
        x = x ^ b;
        x = x | c;
    end

endmodule

// with non blocking assignment
module nonblock_assignment (
    input a, b, c,
    output reg x
);

    always @(a, b, c) begin
        x <= a;
        x <= x ^ b;
        x <= x | c;
    end

endmodule

module blocking_assignment_example2 (
    input a, b, c,
    output reg x
);

    always @(a, b, c) begin
        x = a;
        x = x | c;
        x = x ^ b;
    end

endmodule

module nonblocking_assignment_example2 (
    input a, b, c,
    output reg x
);

    always @(a, b, c) begin
        x <= a;
        x <= x | c;
        x <= x ^ b;
    end

endmodule

module better_circuit (
    input a, b, c,
    output reg x
);

    always @(a, b, c) begin
        x = (a ^ b) | c;
    end

endmodule

// sequential circuits
// use nonblocking assignments with sequential circuits

module pos_D_Flipflop (
    input D,
    input clk,
    output reg Q
);

    always @(posedge clk)
    begin
        Q = D;
    end

endmodule

module flipflop_block_nonblock(
    input D, clk,
    output reg Q1, Q2
);
    always @(posedge clk) begin
        Q1 = D;
        Q2 = Q1;
    end
    
endmodule

module example2_flipflop_block_nonblock(
    input D, clk,
    output reg Q1, Q2
);
    always @(posedge clk) begin
        Q2 = Q1;
        Q1 = D;
    end

endmodule

module example3_flipflop_block_nonblock(
    input D, clk,
    output reg Q1, Q2
);
    always @(posedge clk) begin
        Q1 <= D;
        Q2 <= Q1;
    end

endmodule

module example4_flipflop_block_nonblock(
    input D, clk,
    output reg Q1, Q2
);
    always @(posedge clk) begin
        Q2 <= Q1;
        Q1 <= D;
    end

endmodule
