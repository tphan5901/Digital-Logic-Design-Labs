
//simple register
module simple_register #(parameter N = 4)
(
    input clk,
    input [N - 1:0] I,
    output [N - 1:0] Q
);

    //states
    reg [N - 1:0] Q_reg, Q_next;
    // if clock signal
    always @(posedge clk)
    begin
        //current reg = next 
        Q_reg <= Q_next;
    end
    
    //if input signal
    always @(I)
    begin
        Q_next = I;
    end

    //output
    assign A = Q_reg;

endmodule

//harder implementation of a simple register
module simple_register_harder_implementation #(parameter N = 4)
(
    input clk,
    input [N - 1:0] I,
    output [N - 1:0] Q
);

    //create 4 connected D Flipflops using for loops
    genvar k;
    generate
        for(k = 0; k < N; k = k + 1)
        begin: FF
            D_FF_reset(
                .clk(clk),
                .D(I(K)),
                .Q(Q(K)),
                .reset_n(),
                .clear_n()
            )
        end
    endgenerate

endmodule

//simple register with load(store values)
module simple_register_load #(parameter N = 4)
(
    input clk,
    input load,
    input [N - 1:0] I,
    output [N - 1:0] Q
);

    reg [N - 1:0] Q_reg, Q_next;
    always @(posedge clk)
    begin
        Q_reg <= Q_next;
    end
    
    // next state logic
    always @(I, load)
    begin
        //if there's a val stored
        if(load)
            Q_next = I;
        else
            Q_next = Q_reg;
    end

    assign Q = Q_reg;

endmodule

//shift register
module shift_register #(parameter N = 4)
(
    input clk,
    input SI,
    output [N - 1:0] Q,
    output SO
);

    reg [N - 1:0] Q_reg, Q_next;
    always @(posedge clk)
    begin
        Q_reg <= Q_next;
    end
    
    //next state logic
    always @(SI, Q_reg)
    begin
        //right shift
        Q_next = (SI, Q_reg[N - 1:1]);

        //left shift
    //    Q_next = (Q_reg[N - 2:0], SI)
    end

    assign SO = Q_reg[0]
    assign Q = Q_reg;

endmodule

//shift register with load
module shift_register_load #(parameter N = 4)
(
    input clk,
    input SI,
    input [N - 1:0] I,
    input load,
    input reset_n,
    output [N - 1:0] Q,
    output SO
);

    reg [N - 1:0] Q_reg, Q_next;
    always @(posedge clk, negedge reset_n)
    begin
        if(!reset_n)
            Q_reg <= 1'b0;
        else    
            Q_reg <= Q_next;
    end
    
    //next state logic
    always @(SI, Q_reg)
    begin
        if(load)
            Q_next = I;
        else
            //right shift
            Q_next = (SI, Q_reg[N - 1:1]);

    end

    assign SO = Q_reg[0]
    assign Q = Q_reg;

endmodule

//universal shift register(hard)
module universal_shift_register #(parameter N = 4)
(
    input clk, reset_n,
    input [N - 1:0] I,
    // s can be either s1 or s0
    input [1:0] s,
    input MSB_in, LSB_in,
    output [N - 1:0] Q,
);

    reg [N - 1:0] Q_reg, Q_next;
    always @(posedge clk, negedge reset_n)
    begin
        if(!reset_n)
            Q_reg <= 0;
        else    
            Q_reg <= Q_next;
    end
    
    //next state logic
    always @(Q_reg, MSB_in, LSB_in, I)
    begin
        Q_next = Q_reg
        case(s)
            2'b00: Q_next = Q_reg;
            2'b01: Q_next = (MSB_in, Q_reg[N - 1:0]);
            2'b10: Q_next = (Q_reg[N - 2:0], LSB_in);
            2'b11: Q_next = 1;
            default: Q_next = Q_reg;
        endcase
    end

    //output
    assign Q = Q_reg;

endmodule