
module generic_1bit_mux #(parameter INS = 5) (
    input [INS - 1: 0] w,
    input [$clog2(INS) - 1:0]s,
    output reg f 
);

    integer k;

    always @(w, s)
    begin
        f = 'bx;
        for (k = 0; k < INS; k = k + 1)
            if (k == s)
                f = w[k];
    end

endmodule
