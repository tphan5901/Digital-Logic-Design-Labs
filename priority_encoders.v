
module priority_encoder_switchcase_4x2  (
    input [3:0] w,
    output z,
    output reg [1:0] y
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


module generic_priority_encoder_4x2_testbench();
    reg [3:0] w;
    wire z;
    wire [1:0] y;

    integer k;

    priority_encoder_4x2 uut0(
        .w(w),
        .z(z),
        .y(y)
    );
    
    initial #(10 * 2**4 + 10) $finish;
    
    initial
    begin   
        w = 0;
        for(k = 0; k < 2**4 * 2; k = k + 1)
            #5 w = w + 1;
    end

endmodule


module priority_encoder_4x2 (
    //4 input
    input [3:0] w,
    output z,
    //2 output
    output reg [1:0] y
);
    assign z = |w;

    always @(w)
    begin
        // non defined
        y = 2'bxx;

        //w[0-3] = 4 diff inputs, if any inputs active 
        // select largest input from 11, 10, 01, 00
        if (w[3])
            y = 2'b11;
        else if (w[2])
            y = 2'b10;
        else if (w[1])
            y = 2'b01;
        else if (w[0])
            y = 2'b00;
        else
        // undefined
            y = 2'bxx;
    end

endmodule

