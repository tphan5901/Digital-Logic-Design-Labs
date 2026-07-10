
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


//practice
module pair_detect(
    input clk,
    input inbits,
    input reset,
    //output register
    output reg detect
);

    reg[1:0] state;

    initial begin
        //starting state of 00
        state = 2'b00;
    end

    always@(posedge clk, posedge reset)
    begin
        if(reset)
            state <= 2'b00;
        else
            begin
                case(state) 
                    2'b00:
                        begin
                            if(inbits) state <= 2'b01;
                            else state <= 2'b10;
                        end

                    2'b01:
                        begin
                            if (inbits) state <= 2'b11;
                            else state <= 2'b10;
                        end

                    2'b10:
                        begin
                            if (inbits) state <= 2'b01;
                            else state <= 2'b10;
                        end

                    2'b11:
                        begin
                            if (inbits) state <= 2'b01;
                            else state <= 2'b10;
                        end

                // default block is unnecessary when there is init block that sets default to 2'b00
                //    default: state <= 2'b00;
                endcase
            end
    end

    always @(posedge clk, posedge reset) begin
        // if reset then signal is 0
        if (reset) 
            detect <= 0;
        // if second state then signal is 1
        else if (state == 2'b11)
            detect <= 1;
        // else signal is 0
        else detect <= 0;
    end

endmodule

//testbench for pairdetect()
module testbench;
    reg clk;
    reg reset;
    reg nbits;
    wire detect;

    initial begin
        reset = 1;
        nbits = 0;

        #15 reset = 0;

        //random sequence
        #20 nbits = 1;
        #20 nbits = 0;
        #20 nbits = 1;
        #20 nbits = 0;
        #20 nbits = 1;

        #40 $finish;
    end

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    pair_detect uut (
        .clk(clk),
        .inbits(nbits),
        .reset(reset),
        .detect(detect)
    );
    
endmodule
