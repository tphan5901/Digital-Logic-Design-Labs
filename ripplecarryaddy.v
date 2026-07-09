
module half_adder (
    input x, y,
    output c, a
);

    assign a = x ^ y;
    assign c = x & y;

endmodule

module full_adder (
    input x, y, c_in,
    output a, c_out
);

    wire c1, c2, a1;

    half_adder HA0 (
        .x(x),
        .y(y),
        .c(c1),
        .a(a1)
    );

    half_adder HA1 (
        .x(c_in),
        .y(a1),
        .c(c2),
        .a(a)
    );

    assign c_out = c1 | c2;

endmodule


module rca_4bit(
    input [3:0] x, y,
    input c_in,
    output [3:0] a,
    output c_out
);

    wire [2:0] c;

    full_adder FA0 (
        .x(x[0]),
        .y(y[0]),
        .c_in(c_in),
        .a(a[0]),
        .c_out(c[0])
    );

    full_adder FA1 (
        .x(x[1]),
        .y(y[1]),
        .c_in(c_in),
        .a(a[1]),
        .c_out(c[1])
    );

    full_adder FA2 (
        .x(x[2]),
        .y(y[2]),
        .c_in(c_in),
        .a(a[2]),
        .c_out(c[2])
    );
    
    full_adder FA3 (
        .x(x[3]),
        .y(y[3]),
        .c_in(c[2]),
        .a(a[3]),
        .c_out(c_out)
    );

endmodule
