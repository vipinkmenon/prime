module filter_x(
input            i_clk,
input [7:0]      i_pixel_1,
input [7:0]      i_pixel_2,
input [7:0]      i_pixel_3,
input            i_pixel_valid,
output           o_pixel_ack,
output reg       o_pixel_valid,
input            i_pixel_ack,
output  [7:0]    o_pixel
);


reg [23:0] line1;
reg [23:0] line2;
reg [23:0] line3;
reg        pix_val_int;
reg        pix_val_int_1;
reg [10:0] line1_filt;
reg [10:0] line3_filt;
reg [7 :0] int_pixel;

assign o_pixel_ack = i_pixel_ack;

assign o_pixel = int_pixel;

always @(posedge i_clk)
begin
    if(i_pixel_valid)
	 begin
	    line1  <=  {i_pixel_1,i_pixel_2,i_pixel_3};
		line2  <=  line1;
		line3  <=  line2;
	 end
end

always @(posedge i_clk)
begin
   line1_filt   <=  line1[7:0] + line1[15:8] + line1[23:16] + line3[7:0] + line3[15:8] + line3[23:16] + line2[7:0] + line2[23:16];
   line3_filt   <=  (line2[15:8])<<3;
end

always @(posedge i_clk)
begin
    if(line1_filt > line3_filt)
        int_pixel  <=  (line1_filt-line3_filt)>>3;
    else
	    int_pixel  <=  (line3_filt-line1_filt)>>3;
end

always @(posedge i_clk)
begin
   pix_val_int    <=   i_pixel_valid & o_pixel_ack; //valid data transfer
   pix_val_int_1  <=   pix_val_int;
end

always @(posedge i_clk)
begin
    if(pix_val_int_1)
	     o_pixel_valid   <=    1'b1;
	  else if(o_pixel_valid & i_pixel_ack)
        o_pixel_valid   <=    1'b0;
end		  

endmodule