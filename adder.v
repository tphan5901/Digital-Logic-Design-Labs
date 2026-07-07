
module half_adder (
    input a, y,
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