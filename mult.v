
module mux_2x1_nbit #(parameter N = 3) (
    input [N - 1: 0] w0, w1,
    input a,
    output reg [N - 1: 0] f
);

//    always @(w0, w1, a)
    always @(*)
    begin
        f = a?w1:w0;
    end

endmodule


module mux_4x1_nbit #(parameter N = 3) (
    input [N - 1:0] w0, w1, w2, w3,
    input [1:0] a,
    output reg [N - 1:0] f
);

//    always @(w0, w1, w2, w3, a)
    always @(*)
    begin

    //    f = s[1]?(s[0]? w3: w2):(s[0]? w1: w0);
    
        if (a == 2'b00)
            f = w0;
        else if (a == 2'b01)
            f = w1;
        else if (a == 2'b10)
            f = w2;
        else if (a == 2'b11)
            f = w3;
        else
            f = 'bx; 
            
    end

endmodule
