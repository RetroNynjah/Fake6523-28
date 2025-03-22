`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Engineer:        Per Bengtsson
// 
// Create Date:     2025-01-06
// Module Name:     fake6523-28
// Target Devices:  ATF1504AS
//
// Revision:        0.1
// License:         CC BY-SA 4.0
// 
// Additional Comments: 
// Fake6523-28 for the 1551 paddle. Not tested in any other application
// Based on previous work by Maciej Witkowiak and Jim Brain.
//
//////////////////////////////////////////////////////////////////////////////////

module Fake6523(
                //input _reset,
                input [2:0]rs,
                input _write,
                input _cs,
                inout [7:0]data,
                inout [7:0]port_a,
                inout [1:0]port_b,
                inout [7:6]port_c
                //inout [7:0]port_b,
                //inout [7:0]port_c
					);

// Fake6523
reg [7:0] data_out;

// Ports A/B/C
reg [7:0] ddra;
reg [7:0] pra;

reg [7:0] ddrb;	// 1:0
reg [7:0] prb;		// 1:0

reg [7:0] ddrc;	// 7:6
reg [7:0] prc;		// 7:6

assign port_a[0] = ddra[0] ? pra[0] : 1'bz;
assign port_a[1] = ddra[1] ? pra[1] : 1'bz;
assign port_a[2] = ddra[2] ? pra[2] : 1'bz;
assign port_a[3] = ddra[3] ? pra[3] : 1'bz;
assign port_a[4] = ddra[4] ? pra[4] : 1'bz;
assign port_a[5] = ddra[5] ? pra[5] : 1'bz;
assign port_a[6] = ddra[6] ? pra[6] : 1'bz;
assign port_a[7] = ddra[7] ? pra[7] : 1'bz;

assign port_b[0] = ddrb[0] ? prb[0] : 1'bz;
assign port_b[1] = ddrb[1] ? prb[1] : 1'bz;
/*
assign port_b[2] = ddrb[2] ? prb[2] : 1'bz;
assign port_b[3] = ddrb[3] ? prb[3] : 1'bz;
assign port_b[4] = ddrb[4] ? prb[4] : 1'bz;
assign port_b[5] = ddrb[5] ? prb[5] : 1'bz;
assign port_b[6] = ddrb[6] ? prb[6] : 1'bz;
assign port_b[7] = ddrb[7] ? prb[7] : 1'bz;

assign port_c[0] = ddrc[0] ? prc[0] : 1'bz;
assign port_c[1] = ddrc[1] ? prc[1] : 1'bz;
assign port_c[2] = ddrc[2] ? prc[2] : 1'bz;
assign port_c[3] = ddrc[3] ? prc[3] : 1'bz;
assign port_c[4] = ddrc[4] ? prc[4] : 1'bz;
assign port_c[5] = ddrc[5] ? prc[5] : 1'bz;
*/
assign port_c[6] = ddrc[6] ? prc[6] : 1'bz;
assign port_c[7] = ddrc[7] ? prc[7] : 1'bz;

wire drive_data_out = !_cs && _write;
assign data = drive_data_out ? data_out : 8'bz;

always @(posedge _cs) begin
   if (!_write) begin
      case (rs)
         0: pra = data;
         1: prb <= data;
         2: prc <= data;
         3: ddra <= data;
         4: ddrb <= data;
         5: ddrc <= data;
      endcase
   end
end

always @(*) begin
   case (rs)
      0: data_out = port_a;
      1: begin
				//data_out[7:2] = 0;
				data_out[1:0] = port_b[1:0];
				data_out[7:2] = prb[7:2] & ddrb[7:2]; // read extra bits if set as outputs
			end
      2: begin
				data_out[7:6] = port_c[7:6];
				//data_out[5:0] = 0;
				data_out[5:0] = prc[5:0] & ddrc[5:0]; // read extra bits if set as outputs
			end
      3: data_out = ddra;
      4: data_out = ddrb;
      5: data_out = ddrc;
      default: data_out = 8'bz;
   endcase
end

endmodule
