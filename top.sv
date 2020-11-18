module top(input  logic 		 clk, reset,
			  output logic [31:0] WriteData, DataAdr,
			  output logic 		 MemWrite);
			  
	logic [31:0] PC, Instr, ReadData;
	
	// instantiate processor and memories
	arm arm(clk, reset, PC, Instr, MemWrite, DataAdr,
			  WriteData, ReadData);
	imem imem(PC, Instr);
	dmem dmem(clk, MemWrite, DataAdr, WriteData, ReadData);
endmodule

module dmem(input  logic 		  clk, we,
				input  logic [31:0] a, wd,
				output logic [31:0] rd);
	
	logic [31:0] RAM[63:0];
	
	assign rd = RAM[a[31:2]]; // word aligned
	
	always_ff @(posedge clk)
		if (we) RAM[a[31:2]] <= wd;
endmodule

module imem(input  logic [31:0] a,
				output logic [31:0] rd);
				
	logic [31:0] RAM[63:0];
	
	initial
		$readmemh("memfile.dat",RAM);
		
	assign rd = RAM[a[31:2]]; // word aligned
endmodule