module FIFObuffer( Clk, 

                   dataIn, 

                   RD, 

                   WR, 

                   EN, 

                   dataOut, 

                   Rst,

                   EMPTY, 

                   FULL 

                   ); 

input  Clk, 

       RD, 

       WR, 

       EN, 

       Rst;

output  EMPTY, 

        FULL;

input   [31:0]    dataIn;

output reg [31:0] dataOut; // internal registers 

reg [2:0]  Count = 0; 

reg [31:0] FIFO [0:7]; 

reg [2:0]  readCounter = 0, 

           writeCounter = 0; 

assign EMPTY = (Count==0)? 1'b1:1'b0; 

assign FULL = (Count==8)? 1'b1:1'b0; 

always @ (posedge Clk) 

begin 

 if (EN==0); 

 else begin 

  if (Rst) begin 

   readCounter = 0; 

   writeCounter = 0; 

  end 

  else if (RD ==1'b1 && Count!=0) begin 

   dataOut  = FIFO[readCounter]; 

   readCounter = readCounter+1; 

  end 

  else if (WR==1'b1 && Count<8) begin
   FIFO[writeCounter]  = dataIn; 

   writeCounter  = writeCounter+1; 

  end 

  else; 

 end 

 if (writeCounter==8) 

  writeCounter=0; 

 else if (readCounter==8) 

  readCounter=0; 

 else;

 if (readCounter > writeCounter) begin 

  Count=readCounter-writeCounter; 

 end 

 else if (writeCounter > readCounter) 

  Count=writeCounter-readCounter; 

 else;

end 

endmodule


//timescale 1ns / 1ps

module FIFObuffer_tb;

 // Inputs

 reg Clk;

 reg [31:0] dataIn;

 reg RD;

 reg WR;

 reg EN;

 reg Rst;

 // Outputs

 wire [31:0] dataOut;

 wire EMPTY;

 wire FULL;

 // Instantiate the Unit Under Test (UUT)

 FIFObuffer uut (

                  .Clk(Clk), 

                  .dataIn(dataIn), 

                  .RD(RD), 

                  .WR(WR), 

                  .EN(EN), 

                  .dataOut(dataOut), 

                  .Rst(Rst), 

                  .EMPTY(EMPTY), 

                  .FULL(FULL)

                  );

 initial begin

  // Initialize Inputs

  Clk  = 1'b0;

  dataIn  = 32'h0;

  RD  = 1'b0;

  WR  = 1'b0;

  EN  = 1'b0;

  Rst  = 1'b1;

  // Wait 100 ns for global reset to finish

  #100;        

  // Add stimulus here

  EN  = 1'b1;

  Rst  = 1'b1;

  #20;

  Rst  = 1'b0;

  WR  = 1'b1;

  dataIn  = 32'h0;

  #20;

  dataIn  = 32'h1;

  #20;

  dataIn  = 32'h2;

  #20;

  dataIn  = 32'h3;

  #20;

  dataIn  = 32'h4;

  #20;

  WR = 1'b0;

  RD = 1'b1;  

 end 

   always #10 Clk = ~Clk;    

endmodule