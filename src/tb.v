// Code your testbench here
// or browse Examples
`timescale 1ns/1ps
module tb_handshake_fsm;

    reg clk;
    reg rst;
    reg req;
    wire ack;

    // Instantiate FSM
    handshake_fsm uut (
        .clk(clk),
        .rst(rst),
        .req(req),
        .ack(ack)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 100MHz clock period 10ns

    // Test sequence
    initial begin
        // Initialize
        rst = 1;
        req = 0;
        #15;
        rst = 0;

        // Test handshake
        #10 req = 1;    // Request goes high
        #20 req = 0;    // Request goes low
        #10 req = 1;
        #10 req = 0;

        // Finish simulation
        #20 $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t | rst=%b | req=%b | ack=%b", $time, rst, req, ack);
        $dumpfile("dump.vcd"); $dumpvars;
    end

endmodule

