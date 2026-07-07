

module 4x2_encoder (
    //4 input
    input [3:0] w,
    //2 output
    output reg [1:0] y,
);

    always @(w)
    begin
        y = 2'bxx;
        case(w):
            4'b0001: y = 0; 
            4'b0010: y = 1;
            4'b0100: y = 2;
            4'b1000: y = 3;
            default: y = 2'bxx;
        endcase
    end

endmodule


//encoder impl using if else statement chains
module 4x2_encoder (
    //4 input
    input [3:0] w,
    //2 output
    output reg [1:0] y,
);

    always @(w)
    begin
        y = 2'bxx;

        if (w == 4'b0001)
            y = 2'b00;
        else if (w == 4'b0010)
            y = 2'b01;
        else if (w == 4'b0100)
            y = 2'b10;
        else if (w == 4'b1000)
            y = 2'b11;

    end

endmodule



module 4x2_encoder (
    //4 input
    input [3:0] w,
    output z,
    //2 output
    output [1:0] y,
);
    assign z = |w;

    always @(w)
    begin
        y = 2'bxx;

        if (w[3])
            y = 2'b11;
        else if (w[2])
            y = 2'b10;
        else if (w[1])
            y = 2'b01;
        else if (w[0])
            y = 2'b00;
        else
            y = 2'bxx;
    end

endmodule


module 4x2_encoder (
    //4 input
    input [3:0] w,
    output z,
    //2 output
    output [1:0] y,
);
    assign z = |w;

    always @(w)
    begin
        y = 2'bxx;

        if (w[3])
            y = 2'b11;
        else if (w[2])
            y = 2'b10;
        else if (w[1])
            y = 2'b01;
        else if (w[0])
            y = 2'b00;
        else
            y = 2'bxx;
    end

endmodule


module 4x2_encoder (
    //4 input
    input [3:0] w,
    output z,
    //2 output
    output [1:0] y,
);
    assign z = |w;

    always @(w)
    begin
        y = 2'bxx;

        casex(w)
            4'b1xxx: y = 2'b11;
            4'b01xx: y = 2'b10;
            4'b001x: y = 2'b01;
            4'b0001: y = 2'b00;
            default: y = 2'bxx;
        endcase
    end

endmodule