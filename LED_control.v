module LED(clk, led);
    input clk;
    reg led;
    output led;
    integer p;
    reg clk_1Hz;
    reg current_state, next_state;

    always @(posedge clk)
    begin
        if (p == 25000000 - 1)
        begin
            p = 0;
            clk_1Hz = ~clk_1Hz;
        end
        else
        begin
            p = p + 1;
        end
    end

    parameter s0 = 1'b0,
              s1 = 1'b1;

    always @(posedge clk_1Hz)
        current_state <= next_state;

    always @(current_state)
        case (current_state)
            s0: next_state <= s1;
            s1: next_state <= s0;
            default: next_state <= s0;
        endcase

    always @(current_state)
        case (current_state)
            s0: led <= 1'b0;
            s1: led <= 1'b1;
            default: led <= 1'b0;
        endcase
endmodule