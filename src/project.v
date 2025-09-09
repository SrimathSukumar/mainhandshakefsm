/* 
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module handshake_fsm_tt_um (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    // Map handshake signals
    wire req = ui_in[0];   // request input
    reg ack_reg;           // acknowledgment output

    // FSM state encoding
    typedef enum logic [1:0] {
        IDLE      = 2'b00,
        ACK_STATE = 2'b01
    } state_t;

    state_t current_state, next_state;

    // State transition
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    // Next state logic
    always_comb begin
        case (current_state)
            IDLE:      next_state = req ? ACK_STATE : IDLE;
            ACK_STATE: next_state = req ? ACK_STATE : IDLE;
            default:   next_state = IDLE;
        endcase
    end

    // Output logic
    always_comb begin
        case (current_state)
            IDLE:      ack_reg = 1'b0;
            ACK_STATE: ack_reg = 1'b1;
            default:   ack_reg = 1'b0;
        endcase
    end

    // Assign outputs
    assign uo_out  = {7'b0, ack_reg}; // ack on uo_out[0]
    assign uio_out = 8'b0;            // unused IO outputs
    assign uio_oe  = 8'b0;            // IO direction (0=input)

    // Prevent unused signal warnings
    wire _unused = &{ui_in[7:1], uio_in, ena};

endmodule
