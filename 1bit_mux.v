
//complex
module generic_1bit_mux #(parameter INS = 5) (
    // 1:0 is 2bits. 00(2bits) so it can represent signal input of 0 or 1 in 00
    input [INS - 1:0] w, 
    // selected input
    // takes in parameter n calculates num of bits to represent INS. 000(3bits) so it can hold val 5 in binary
    input [$clog2(INS) - 1:0] s,
    output reg f 
);

    integer k;

    always @(w, s) // or always @(*)
    begin
        // default output reg f if no input is selected
        f = 'bx;
        // loop
        for (k = 0; k < INS; k = k + 1)
            // if input signal match selected input
            if (k == s)
            // send to output reg
                f = w[k];
    end

endmodule
