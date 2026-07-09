
//generic decoder
module generic_decoder #(parameter N = 3) (
    input [N - 1:0] w,
    //enable signal
    input en,
    output reg [0: 2 ** N - 1] y
);

    always @(w, en)
    begin
        //default
        y = 'b0;

        //check for enable signal
        if (en)
            y[1] = 1'b1;
        else
            y = 'b0;

    end

endmodule


// 2 means two input, 4 means four output
module decoder_using_if_statements (
    input [1:0] w,
    output reg [0:3] y
);

    always @(w)
    begin

        y = 4'b0000;

        if(w == 2'b00)
            y[0] = 1'b1;
        else if (w == 2'b01)
            y[1] = 1'b1;
        else if (w == 2'b10)
            y[2] = 1'b1;
        else if (w == 2'b11)
            y[3] = 1'b1;
        else
            y = 4'b0000;
    
    end

endmodule

//2x4 decoder using switch case statements
module decoder_using_switchcase (
    input [1:0] w,
    output reg [0:3] y
    
);

    always @(w)
        begin

            y = 4'b0000;

            case(w)
                0: y = 4'b1000;
                1: y = 4'b0100;
                2: y = 4'b0010;
                3: y = 4'b0001;
                default: y = 4'b0000;
            endcase
        
        end

endmodule


//easiest impl of decoder
//2x4 decoder
module decoder (
    input [1:0] w,
    output reg [0:3] y
    
);

    always @(w)
        begin

            y = 4'b0000;
            y[w] = 1'b1;
            
        end

endmodule

