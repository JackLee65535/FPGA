`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/06/30 11:03:49
// Design Name: 
// Module Name: dds
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


module dds(
    input               sclk,
    input               rst_n,
    input               dds_en,
    input       [31:0]  freq_ctrl,
    input       [11:0]  phase_ctrl,
    output      [11:0]  dds_data,
    output  reg         dds_data_en
    );
    
    parameter       N = 32;
    parameter       M = 12;
    
    reg     [N-1:0] pa;
    wire    [2*N-1:0] Fword;
    wire    [M-1:0] Pword;
    wire    [M-1:0] romaddr;
    
    assign Fword = (freq_ctrl<<N)/100000000;
    assign Pword = (phase_ctrl<<M)/360;
    assign romaddr = pa[N-1:N-M] + Pword; 
    
    always@(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
    pa <= 32'b0;
    else if(dds_en == 1'b1)
    pa <= pa + Fword;
    else 
    pa <= 32'b0;
    
    always@(posedge sclk or negedge rst_n)
    if(rst_n == 1'b0)
    dds_data_en <= 1'b0;
    else 
    dds_data_en <= dds_en;
    
    mem_4096x1024 mem(
    .sclk   (sclk       ),
    .rst_n  (rst_n      ),
    .en     (dds_en     ),
    .addr   (romaddr    ),
    .data   (dds_data   )
    );
    
endmodule
