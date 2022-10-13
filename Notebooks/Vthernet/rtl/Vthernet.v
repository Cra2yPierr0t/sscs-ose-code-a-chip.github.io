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

    wire        rx_data_v;
    wire [7:0]  rx_data;
    wire [7:0]  rx_mem_out;
    wire [31:0] rx_addr;
    
    // PicoRV interface
    wire        rx_irq;

    RX_Vthernet_MAC RX_Vthernet_MAC(
        .rst        (wb_rst_i   ),
        // Wishbone interface
        .wb_clk_i   (wb_clk_i   ),
        .wb_rst_i   (wb_rst_i   ),
        .wbs_stb_i  (wbs_stb_i  ),
        .wbs_cyc_i  (wbs_cyc_i  ),
        .wbs_we_i   (wbs_we_i   ),
        .wbs_sel_i  (wbs_sel_i  ),
        .wbs_dat_i  (wbs_dat_i  ),
        .wbs_adr_i  (wbs_adr_i  ),
        .wbs_ack_o  (wbs_ack_o  ),
        .wbs_dat_o  (wbs_dat_o  ),
        // GMII interface
        .GTX_CLK    (GTX_CLK    ),
        .TX_EN      (TX_EN      ),
        .TXD        (TXD        ),
        .TX_ER      (TX_ER      ),
        .RX_CLK     (RX_CLK     ),
        .RX_DV      (RX_DV      ),
        .RXD        (RXD        ),
        .RX_ER      (RX_ER      ),
        .MDC        (MDC        ),
        .MDIO       (MDIO       ),
        // PicoRV interface
        .rx_irq     (rx_irq     ),
        // Memory Interface
        .rx_data_v  (rx_data_v  ),
        .rx_data    (rx_data    ),
        .rx_mem_out (rx_mem_out ),
        .rx_addr    (rx_addr    )
    );
endmodule
`default_nettype wire
