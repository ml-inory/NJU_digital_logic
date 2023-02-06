module bcd8seg(
  input  [3:0] b,
  output reg [7:0] h
);
    always @(*) begin
        case (b)
            4'd0:   h = 8'b11111100;
            4'd1:   h = 8'b01100000;
            4'd2:   h = 8'b11011010;
            4'd3:   h = 8'b11110010;
            4'd4:   h = 8'b01100110;
            4'd5:   h = 8'b10110110;
            4'd6:   h = 8'b10111110;
            4'd7:   h = 8'b11100000;
            4'd8:   h = 8'b11111110;
            4'd9:   h = 8'b11110110;
            default: h = 8'b0000000;
        endcase
        h = ~h;
    end
endmodule