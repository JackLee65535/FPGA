`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/30 11:21:10
// Design Name: 
// Module Name: tb_dds
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_dds(

    );
    reg         sclk;
    reg         rst_n;
    reg         dds_en;
    reg [31:0]  freq_ctrl;
    reg [11:0]  phase_ctrl;
    wire[11:0]  dds_data;
    wire        dds_data_en;
    initial begin 
    sclk    =   1'b0;
    rst_n   =   1'b0;
    end
    
    always  #5  sclk = ~sclk;
    
    initial begin 
    dds_en      =   1'b0;
    freq_ctrl   =   32'd0;
    phase_ctrl  =   12'd0;
    #500
    dds_en  =   1'b1;
    freq_ctrl   =   32'd1000000;
    phase_ctrl  =   90;
    #20000
    freq_ctrl   =   32'd100000;
    phase_ctrl  =   180;
    end
    
    
    dds dds(
    .sclk            (sclk           ),              
    .rst_n           (rst_n          ),
    .dds_en          (dds_en         ),
    .freq_ctrl       (freq_ctrl      ),
    .phase_ctrl      (phase_ctrl     ),
    .dds_data        (dds_data       ),
    .dds_data_en     (dds_data_en    )
    );
    
endmodule
