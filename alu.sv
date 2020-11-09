module alu (A, B, ALUControl, Result, ALUFlags);
	input logic [1:0] ALUControl;
	input logic [31:0] A, B;
	output logic [31:0] Result;
	output logic [3:0] ALUFlags;
	
	wire [31:0] B_Temp;
	wire [31:0] sum;
	wire cout;
	
	mux2a1 mux2a1 (ALUControl[0], B, B_Temp);
	
	add32 add32(A, B_Temp, ALUControl[0], sum, cout);
	
	mux4a1 mux4a1 (sum, sum, A & B, A | B, ALUControl, Result);
	
endmodule

module add32 (a, b, cin, sum, cout);
	input logic [31:0] a, b;
	input logic cin;
	output logic [31:0] sum;
	output logic cout;
	
	assign {cout, sum} = a + b + cin;
	
endmodule

module mux2a1 (s, d0, y);
	input logic s;
	input logic [31:0] d0;
	output logic [31:0] y;
	
	assign y = s ? !d0 : d0;
	
endmodule

module mux4a1 (a, b, c, d, sel, result);
	input logic [31:0] a,b,c,d;
	input logic [1:0] sel;
	output logic [31:0] result;

	always @(a or b or c or d or sel)
		begin
			case(sel)
				2'b00: result = a;
				2'b01: result = b;
				2'b10: result = c;
				2'b11: result = d;
			endcase
		end
endmodule

module alu_testbench ();
	input [1:0] ALUControl;
	input [31:0] A, B;
	output [31:0] Result;
	output [3:0] ALUFlags;
	
	alu alu (A, B, ALUControl, Result, ALUFlags);
	
	initial begin
		
	end
	
endmodule
