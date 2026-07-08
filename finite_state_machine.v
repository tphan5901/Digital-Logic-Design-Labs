
//this is a moore machine
module finite_state_machine(
    input clk,
    input reset,
    input x,
    output reg y
);

    reg[2:0] current_state, next_state;
    typedef enum logic [2:0] {A, B, C, D, E} State;

    always @(posedge clk) begin
        if (reset)
            current_state <= A;
        else current_state <= next_state;
    end

    //combinational circuit
    always_comb begin
        case (current_state)

            A: if(x) next_state = C;
                else next_state = B;
            B: if(x) next_state = D;
                else next_state = B;
            C: if(x) next_state = C;
                else next_state = E;
            D: if(x) next_state = C;
                else next_state = E;
            E: if(x) next_state = D;
                else next_state = B;
            default: next_state = A;
            
        endcase

        assign y = (current_state == D | current_state == E);

    end

endmodule
