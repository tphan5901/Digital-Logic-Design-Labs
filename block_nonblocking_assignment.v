
module block_nonblock (
    input a, b, c,
    output reg x
);

    always @(a, b, c) begin
        x = a;
        x = x ^ b;
        x = x | c;
    end

endmodule
