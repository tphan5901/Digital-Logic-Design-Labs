
// 4 bit multiplexor
module mux_4x1_nbit 
    #(parameter N = 3)
(
    input [N - 1:0] w0, w1, w2, w3,
    input [1:0] a,
    output reg [N - 1:0] f
);

    always @(w0, w1, w2, w3, a)
    begin

    // f = s[1]?(s[0]? w3: w2):(s[0]? w1: w0);

    // same output as line 33
        if (s == 2'b00)
            f = w0;
        else if (s == 2'b01)
            f = w1;
        else if (a == 2'b10)
            f = w2;
        else if (a == 2'b11)
            f = w3;
        else
            f = 'bx; 


    //same output as if else statement chain & line 33   
    /*
        case(a)
            2'b00: f = w0;
            2'b01: f = w1;
            2'b10: f = w2;
            2'b11: f = w3;
            default: f = 'bx;

        endcase
    */
    
    end

endmodule