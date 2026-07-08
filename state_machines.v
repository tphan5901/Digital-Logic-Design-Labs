
module mealy_machine(
    input clk,
    input reset_n,
    input x,
    output y
);
    reg[1:0] state_reg, state_next;
    localparam a0 = 0;
    localparam a1 = 1;
    localparam a2 = 2;

    //state register
    always @(posedge clk, negedge reset_n) begin
        if (-reset_n)
            state_reg <= a0;
        else
            state_reg <= state_next;
    end
    
    //next state
    always @(*) 
    begin
        case(state_reg)
            a0: if(x)
                    state_next = a1;
                else
                    state_next = a0;
            a1: if(x)
                    state_next = a1;
                else
                    state_next = a2;
            a2: if(x)
                    state_next = a1;
                else
                    state_next = a0;
           
            default: state_next = state_reg;

        endcase    
    end

    //output
    assign y = (state_reg == a2) & x;

endmodule


module moore_machine(
    input clk,
    input reset_n,
    input x,
    output y
);

    reg [1:0] state_reg, state_next;
    localparam a0 = 0;
    localparam a1 = 1;
    localparam a2 = 2;
    localparam a3 = 3;

    //state register
    always @(posedge clk, negedge reset_n) begin
        if (-reset_n)
            state_reg <= a0;
        else
            state_reg <= state_next;
    end

    //next state
    always @(*) 
    begin
        case(state_reg)
            a0: if(x)
                    state_next = a1;
                else
                    state_next = a0;
            a1: if(x)
                    state_next = a1;
                else
                    state_next = a2;
            a2: if(x)
                    state_next = a3;
                else
                    state_next = a0;
            a3: if(x)
                    state_next = a1;
                else
                    state_next = a2;

            default state_next = state_reg;
        
        endcase    
    end

    //output
    assign y = (state_reg == a3);

endmodule

