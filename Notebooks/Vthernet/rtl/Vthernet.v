`default_nettype none
module Vthernet (
    input   wire        rst,
    input   wire        clk,

    // GMII interface
    output  reg         GTX_CLK,
    output  reg         TX_EN,
    output  reg [7:0]   TXD,
    output  reg         TX_ER,

    input   wire        RX_CLK,
    input   wire        RX_DV,
    input   wire [7:0]  RXD,
    input   wire        RX_ER,

    output  reg         MDC,
    inout   reg         MDIO
);

    // Wishbone interface
    wire        wb_clk_i;
    wire        wb_rst_i;
    wire        wbs_stb_i;
    wire        wbs_cyc_i;
    wire        wbs_we_i;
    wire  [3:0] wbs_sel_i;
    wire [31:0] wbs_dat_i;
    wire [31:0] wbs_adr_i;
    wire        wbs_ack_o;
    wire [31:0] wbs_dat_o;
    
    Vthernet_RX_MAC Vthernet_RX_MAC(
        .rst(rst),
        .clk(clk),
        
        // CSRs
        .my_mac_addr(),
        .ethernet_len_type(),
        .dst_mac_addr(),
        .src_mac_addr(),
        
        // CPU interface
        .rx_irq(),
        
        // GMII interface
        .RX_CLK(RX_CLK),
        .RX_DV(RX_DV),
        .RXD(RXD),
        .RX_ER(RX_ER),
        
        // Memory interface
        .rx_mem_wen(),
        .rx_mem_data(),
        .rx_mem_addr()
    );
    
    Vthernet_TX_MAC Vthernet_TX_MAC(
        // CSRs
        // Write Only
        .my_mac_addr(),
        // Read Only
        // GMII interface
        .GTX_CLK(GTX_CLK),
        .TX_EN(TX_EN),
        .TXD(TXD),
        .TX_ER(TX_ER),
        // Memory interface
        .tx_mem_valid(),
        .tx_mem_data()
    );
endmodule
`default_nettype wire
