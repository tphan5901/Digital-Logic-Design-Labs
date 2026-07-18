
//counter as timers
module timer_parameter #(parameter FINAL_VALUE = 255) (
    input clk,
    input reset_n,
    input enable,
//    output [bits - 1:0] Q
    output done
);

    //register size
    localparam BITS = $clog2(FINAL_VALUE);
    //two registers, (reg stands for register)
    reg [BITS - 1:0] Q_reg, Q_next;

    always @(posedge clk, negedge reset_n) begin
    // reset signal
        if (~reset_n)
    // current reg count = b0 means 00000000 so count is 0
            Q_reg <= 'b0;
    // if enable signal, then start timer
        else if(enable)
    // current count(Q_reg) = new count(Q_next) 
            Q_reg <= Q_next;
        else
            Q_reg <= Q_reg;
    end

    //assign checks if q_reg = final_value, if so then done = 1
    assign done = Q_reg == FINAL_VALUE;

    always @(*) begin
    //    Q_next = done? 'b0: Q_reg + 1;   

    //if else statement is equilvalent of ternary operator above
        if (done)
            Q_next = 0;
        //keep incrementing count
        else
            Q_next = Q_reg + 1;
    end

endmodule

//testbench for timer_parameter method
module timer_parameter_tb();
    localparam FINAL_VALUE = 49_999;
    localparam bits = $clog2(FINAL_VALUE);

    reg clk, reset_n, enable;
    wire done;

    //call method, timer_parameter
    timer_parameter #(.FINAL_VALUE(FINAL_VALUE)) uut (
        .clk(clk),
        .reset_n(reset_n),
        .enable(enable)
    );

endmodule
