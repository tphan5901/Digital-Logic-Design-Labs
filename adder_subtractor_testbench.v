
module adder_subtractor_testbench ();
    // 1. declare local reg * write identifier
    parameter n = 4;
    reg signed [n - 1 : 0] x, y;
    reg add_n;
    wire signed [n - 1: 0] a;
    wire c_out, overflow;

    // 2. instantiate module under test
    adder_subtractor #(.n(n)) uut (
        .x(x),
        .y(y),
        .add_n(add_n),
        .a(a),
        .c_out(c_out),
        .overflow(overflow)
    );

    // 3. specify a stopwatch to stop simulation
    initial 
    begin
        #40 $finish;
    end

    // 4. generate stimuli using initial & always

    initial begin
        // 5 + 6
        add_n = 1'b0;
        x = 4'd5;
        y = 4'd6;

        #10

        // 5 - 6
        add_n = 1;

        #10

        // 6 - (-3)
        x = 6;
        y = -3;

        #10

        // -4 + (-5)
        add_n = 0;
        x = -4;
        y = -5;

        #10;

    end

    // 5. display output response (text or graphic (or both))
    initial begin
        $monitor("time = %2d: x = %2d \t y = %2d \t add_n = %b \t result = %2d \t cout = %b \t overflow = %b",
        $time, x, y, add_n, a, c_out, overflow);
    end

endmodule
