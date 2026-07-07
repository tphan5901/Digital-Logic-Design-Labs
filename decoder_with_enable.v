
//2x4 decoder w/ enable
module decoder_2x4 (
    input [1:0] w,
    input en,
    output reg [0:3] y
    
);

    always @(w, en)
    begin
        y[w] = 1'b1;
        
        if (en)
        begin

            case(w)
                0: y = 4'b1000;
                1: y = 4'b0100;
                2: y = 4'b0010;
                3: y = 4'b0001;
                default: y = 4'b0000;
        endcase
        end

        else
            y = 4'b0000;

    end

endmodule
