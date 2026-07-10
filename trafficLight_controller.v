
module trafficlight_controller(
    input clk, reset_n,
    input Sa, Sb,
    output reg Ra, Ya, Ga,
    output reg Rb, Yb, Gb
);
    reg[3:0] state_reg, state_next;
    localparam s0 = 0, s1 = 1, s2 = 2, s3 = 3, s4 = 4, s5 = 5, s6 = 6,
    s7 = 7, s8 = 8, s9 = 9, s10 = 10, s11 = 11, s12 = 12;
    
    //state register
    always @(posedge clk, negedge reset_n) begin
        if (~reset_n)
                state_reg <= s0;
            else
                state_reg <= state_next;
    end 
    
    //next state
    always @(*) 
    begin
        state_next = state_reg;
        case(state_reg)
            s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10:
                    state_next = state_reg + 1;
            s5: if(~Sb)
                    state_next = s5;
                else
                    state_next = s6;
            s11: if(~Sa & Sb)
                    state_next = s11;
                else if (Sa | Sb)
                    state_next = s12;
            s12: state_next = s0;
           
            default: state_next = s0;

        endcase    
    end

    //output
    always @(*) begin
    //lights at state 0
        Ra = 1'b0;
        Ya = 1'b0;
        Ga = 1'b0;
        Rb = 1'b0;
        Yb = 1'b0;
        Gb = 1'b0;
        
        case(state_reg)
            s0, s1, s2, s3, s4, s5:
                begin
                    Ga = 1'b1;
                    Rb = 1'b1;
                end
            s6: 
                begin
                    Ya = 1'b1;
                    Rb = 1'b1;
                end
            s7, s8, s9, s10, s11:
                begin
                    Ra = 1'b1;
                    Gb = 1'b1;
                end
            s12:
                begin
                    Ra = 1'b1;
                    Yb = 1'b1;
                end
        endcase
    end

endmodule



