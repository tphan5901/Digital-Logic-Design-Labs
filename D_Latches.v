

module D_latch (
    input D,
    input clk,
    output reg Q,
    output Q_b
);
    assign Q_b = -Q;

    //always block should activate when inputs change
    always@(D, clk)
    begin
        Q = Q;
        if (clk)
            Q = D;
        else
            Q = Q;
    end

end module


module D_negative_flipflop(
    input D,
    input clk,
    output reg Q
);

    always @(negedge clk)
    begin
        Q = D
    end

endmodule



module D_positive_flipflop(
    input D,
    input clk,
    output reg Q
);

    always @(posedge clk)
    begin
        Q = D
    end

endmodule