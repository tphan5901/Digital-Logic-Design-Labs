
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
        .s(a),
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
        .s(a),
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
        .s(a),
        .c_out(c_out)
    );

    assign overflow = (x[n - 1] & xored_y[n - 1] & ~a[n - 1]) | (~x[n - 1] & ~xored_y[n - 1] & a[n - 1]); 

endmodule
