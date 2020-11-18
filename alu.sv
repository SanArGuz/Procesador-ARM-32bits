module alu (A, B, ALUControl, Result, ALUFlags);
				input  logic [1:0]  ALUControl;
				input  logic [31:0] A, B;
				output logic [31:0] Result;
				output logic [3:0]  ALUFlags;
	
	wire [31:0] B_Temp;
	wire [31:0] sum;
	wire cout;
	
	mux2a1 mux2a1 (ALUControl[0], B, B_Temp);
	
	add32 add32(A, B_Temp, ALUControl[0], sum, cout);
	
	mux4a1 mux4a1 (sum, sum, A & B, A | B, ALUControl, Result);
	
	flags flags(Result, cout, ALUControl, sum, A, B, ALUFlags);
	
endmodule

module add32 (a, b, cin, sum, cout);
				input  logic [31:0] a, b;
				input  logic 		  cin;
				output logic [31:0] sum;
				output logic 		  cout;
	
	assign {cout, sum} = a + b + cin;
	
endmodule

module mux2a1 (s, d0, y);
				input  logic 		  s;
				input  logic [31:0] d0;
				output logic [31:0] y;
	
	assign y = s ? ~d0: d0;
	
endmodule

module mux4a1 (a, b, c, d, sel, result);
				input  logic [31:0] a,b,c,d;
				input  logic [1:0]  sel;
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


module flags(result, cout, ALUControl, Sum, A, B, ALUFlags);
				input  logic [31:0] result, A, B, Sum;
				input  logic 		  cout;
				input  logic [1:0]  ALUControl;
				output logic [3:0]  ALUFlags;
	
	assign ALUFlags[3] = result[31] ? 1'b1 : 1'b0; //Negativo
	
	assign ALUFlags[2] = result ? 1'b0 : 1'b1; //Zero
	
	assign ALUFlags[1] = ~ALUControl[1] & cout; //Carry
	
	assign ALUFlags[0] = ~(A[31]^B[31]^ALUControl[0]) & (A[31]^Sum[31]) & ~ALUControl[1]; //Overflow
	
endmodule

module alu_testbench ();
				logic [1:0]  ALUControl;
				logic [31:0] A, B;
				logic [31:0] Result;
				logic [3:0]  ALUFlags;
	
	alu alu(A, B, ALUControl, Result, ALUFlags);
	
	initial begin
		A = 32'h00000000;
		B = 32'h00000000;
		ALUControl = 2'b00;
		#100;
		
		A = 32'h00000000;
		B = 32'hFFFFFFFF;
		ALUControl = 2'b00;
		#100;
		
		A = 32'h00000001;
		B = 32'hFFFFFFFF;
		ALUControl = 2'b00;
		#100;
		
		A = 32'h000000FF;
		B = 32'h00000001;
		ALUControl = 2'b00;
		#100;
		
		A = 32'h00000000;
		B = 32'h00000000;
		ALUControl = 2'b01;
		#100;
		
		A = 32'h00000000;
		B = 32'hFFFFFFFF;
		ALUControl = 2'b01;
		#100;
		
		A = 32'h00000001;
		B = 32'h00000001;
		ALUControl = 2'b01;
		#100;
		
		A = 32'h00000100;
		B = 32'h00000001;
		ALUControl = 2'b01;
		#100;
		
		A = 32'hFFFFFFFF;
		B = 32'hFFFFFFFF;
		ALUControl = 2'b10;
		#100;
		
		A = 32'hFFFFFFFF;
		B = 32'h12345678;
		ALUControl = 2'b10;
		#100;
		
		A = 32'h12345678;
		B = 32'h87654321;
		ALUControl = 2'b10;
		#100;
		
		A = 32'h00000000;
		B = 32'hFFFFFFFF;
		ALUControl = 2'b10;
		#100;
		
		A = 32'hFFFFFFFF;
		B = 32'hFFFFFFFF;
		ALUControl = 2'b11;
		#100;
		
		A = 32'h12345678;
		B = 32'h87654321;
		ALUControl = 2'b11;
		#100;
		
		A = 32'h00000000;
		B = 32'hFFFFFFFF;
		ALUControl = 2'b11;
		#100;
		
		A = 32'h00000000;
		B = 32'h00000000;
		ALUControl = 2'b11;
		#100;
	end
	
endmodule