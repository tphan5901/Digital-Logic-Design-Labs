
//a subtractor needs a ripple carry adder
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


module rca_nbit (
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
        .c_in(c[0]),
        .a(a[1]),
        .c_out(c[1])
    );

    full_adder FA2 (
        .x(x[2]),
        .y(y[2]),
        .c_in(c[1]),
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

module subtractor_4bit (
    input [3:0] x, y,
    input add_n,
    output [3:0] a,
    output c_out
);

    wire [3:0] xored_y;

    // y + add
    assign xored_y[0] = y[0] ^ add_n;
    assign xored_y[1] = y[1] ^ add_n;
    assign xored_y[2] = y[2] ^ add_n;
    assign xored_y[3] = y[3] ^ add_n;

    rca_nbit A0 (
        .x(x),
        .y(xored_y),
        .c_in(add_n),
        .a(a),
        .c_out(c_out)
    );

endmodule


//parametized
module adder_subtractor_4bit #(parameter n = 4) (
    input [n - 1:0] x, y,
    input add_n,
    output [n - 1:0] a,
    output c_out
    
);

    wire [n - 1:0] xored_y;

    generate
        genvar k;

        for (k = 0; k < n; k = k + 1)
            begin : bit
                assign xored_y[k] = y[k] ^ add_n;
            end

    endgenerate

    // instead of generate block, you could xor the output with add_input * n times
    // assign xored_y = y ^ {n{add_n}}

    rca_nbit #(.n(n)) A0 (
        .x(x),
        .y(xored_y),
        .c_in(add_n),
        .a(a),
        .c_out(c_out)
    );

endmodule


//parametized
//add overflow 
module nbit_adder_subtractor #(parameter n = 4) (
    input [n - 1:0] x, y,
    input add_n,
    output [n - 1:0] a,
    output c_out,
    //signed & unsigned num
    output overflow
);

    //declare diff signals
    wire [n - 1:0] xored_y;

    //generate several xor gates
    generate
        genvar k;

        for (k = 0; k < n; k = k + 1)
            begin : bit
                assign xored_y[k] = y[k] ^ add_n;
            end
    endgenerate

    rca_nbit #(.n(n)) A0 (
        .x(x),
        .y(xored_y),
        .c_in(add_n),
        .a(a),
        .c_out(c_out)
    );

    assign overflow = (x[n - 1] & xored_y[n - 1] & ~a[n - 1]) | (~x[n - 1] & ~xored_y[n - 1] & a[n - 1]); 

endmodule
