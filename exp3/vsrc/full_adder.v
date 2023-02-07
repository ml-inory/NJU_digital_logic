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

    reg [2:0] cout_tmp;
    wire cf;

    full_adder fa1(a[0], b[0], cin, sum[0], cout_tmp[0]);
    full_adder fa2(a[1], b[1], cout_tmp[0], sum[1], cout_tmp[1]);
    full_adder fa3(a[2], b[2], cout_tmp[1], sum[2], cout_tmp[2]);
    full_adder fa4(a[3], b[3], cout_tmp[2], sum[3], carry);

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