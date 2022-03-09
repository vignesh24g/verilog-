module match(win,one,two,sel);
	input [1:0]one;
	input [1:0]two;
	input sel;
	output [1:0]win;
	assign win=(sel)?two:one;
	//0 means team one wins,1 means team 2 wins
endmodule

module tournament(champion,a,b,c,d,s2,s1,s0);
	input [1:0]a;
	input[1:0]b;
	input [1:0]c;
	input[1:0]d;
	input s2;
	input s1;
	input s0;
	output [1:0]champion;
	wire [1:0]sf1;
	wire [1:0]sf2;
	match semifinal1(sf1,a,b,s0);
	//semifinal match between a and b team
	match semifinal2(sf2,c,d,s1);
	//semifinal match between c and d team
	match finals(champion ,sf1,sf2,s2);
	//final is between winner of sf1 and sf2
endmodule