/* verilator lint_off UNOPTFLAT */
module full_adder(a, b, cin, sum, cout);
    input a;
    input b;
    input cin;
    output sum;
    output cout;

    wire xor_ab;
    wire and_ab;
    wire and_c_xorab;

    assign xor_ab = a ^ b;
    assign and_ab = a & b;
    assign sum = cin ^ xor_ab;
    assign and_c_xorab = cin & xor_ab;
    assign cout = and_c_xorab | and_ab;
endmodule

module full_adder_4b(a, b, cin, sum, carry, zero, overflow);
    input [3:0] a;
    input [3:0] b;
    input cin;
    output [3:0] sum;
    output carry;
    output zero;
    output overflow;

    wire [3:0] cout_tmp;
    wire cf;

    full_adder fa1(a[0], b[0], cin, sum[0], cout_tmp[0]);
    genvar        i ;
    generate
        for(i=1; i<=3; i=i+1) begin: adder_gen
        full_adder  u_adder(
            .a     (a[i]),
            .b     (b[i]),
            .cin   (cout_tmp[i-1]), //上一个全加器的溢位是下一个的进位
            .sum   (sum[i]),
            .cout  (cout_tmp[i]));
        end
    endgenerate

    assign carry = cout_tmp[3];
    assign cf = a[3] & b[3];
    assign overflow = cf ^ carry;
    assign zero = ~(| sum);
endmodule

module sub_4b(a, b, cin, sum, carry, zero, overflow);
    input [3:0] a;
    input [3:0] b;
    input cin;
    output [3:0] sum;
    output carry;
    output zero;
    output overflow;

    reg [3:0] inv_b = ~b;
    reg [3:0] neg_b;
    full_adder_4b fa_neg(
        .a  (inv_b), 
        .b  (4'b0001),
        .sum (neg_b)
    );
    full_adder_4b fa_out(a, neg_b, cin, sum, carry, zero, overflow);
endmodule