module fullAdder (A, B, Cin, Sum, Cout);
	input logic A,B,Cin;
	output logic Sum,Cout;
	
	assign Sum = A ^ B ^ Cin;
	assign Cout = A&B | (A ^ B) & Cin;
	
endmodule	

module fullAdder_testbench();
	logic A,B,Cin,Sum,Cout;
	
	fullAdder fa(A, B, Cin, Sum, Cout);
	
	integer i;
	initial begin
	
//		A = 0; B = 0; Cin = 0; #10;
//		              Cin = 1; #10;
//		       B = 1; Cin = 0; #10;				  
//		              Cin = 1; #10;
//		A = 1; B = 0; Cin = 0; #10;
//		              Cin = 1; #10;
//		       B = 1; Cin = 0; #10;				  
//		              Cin = 1; #10;
		for (i=0; i<2**3; i++) begin
		  {A, B, Cin} = i; #50;
		end
		
		$stop;
		
	end // initial	
	
endmodule