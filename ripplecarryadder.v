

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
        .s(a[0]),
        .c_out(c[0])
    );

    full_adder FA1 (
        .x(x[1]),
        .y(y[1]),
        .c_in(c_in),
        .s(a[1]),
        .c_out(c[1])
    );

    full_adder FA2 (
        .x(x[2]),
        .y(y[2]),
        .c_in(c_in),
        .s(a[2]),
        .c_out(c[2])
    );
    
    full_adder FA3 (
        .x(x[3]),
        .y(y[3]),
        .c_in(c_in),
        .s(a[3]),
        .c_out(c[3])
    );

endModule