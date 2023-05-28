module shiftAddMultiplier (
  input wire [7:0] multiplicand,
  input wire [7:0] multiplier,
  input wire clk,
  input wire reset,
  input wire start,
  output reg [15:0] product
);

  always @(posedge clk) begin
    if (reset) begin
      product <= 16'b0;
    end else begin
      if (start) begin
        product <= 16'b0;
        for (i = 0; i < 8; i = i + 1) begin
          if (multiplier[i] == 1) begin
            product <= product + (multiplicand << i);
          end
        end
      end
    end
  end
endmodule

module testbench;
  reg [7:0] multiplicand;
  reg [7:0] multiplier;
  reg clk, reset, start;
  wire [15:0] product;

  shiftAddMultiplier dut (
    .multiplicand(multiplicand),
    .multiplier(multiplier),
    .clk(clk),
    .reset(reset),
    .start(start),
    .product(product)
  );

  initial begin
    clk = 0;
    reset = 1;
    start = 0;
    multiplicand = 8'b0;
    multiplier = 8'b0;
    #10 reset = 0;
    #5 start = 1;
    #5 start = 0;
    #10 $finish;
  end

  always begin
    #5 clk = ~clk;
  end
endmodule
