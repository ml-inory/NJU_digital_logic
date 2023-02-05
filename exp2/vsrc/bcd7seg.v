module bcd7seg(
  input  [3:0] b,
  output reg [6:0] h
);
    always @(*) begin
        case (b)
            4'd0:   h = 7'b0111111;
            4'd1:   h = 7'b0000110;
            4'd2:   h = 7'b1011001;
            4'd3:   h = 7'b1001111;
            4'd4:   h = 7'b1100110;
            4'd5:   h = 7'b1101101;
            4'd6:   h = 7'b1111101;
            4'd7:   h = 7'b0000111;
            4'd8:   h = 7'b1111111;
            4'd9:   h = 7'b1101111;
            default: h = 7'b0000000;
        endcase
        h = ~h;
    end
endmodule