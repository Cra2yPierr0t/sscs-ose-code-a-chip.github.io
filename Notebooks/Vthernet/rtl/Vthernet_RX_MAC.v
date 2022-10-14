//
//  ethernet --- IP ---- UDP
//            |       |
//            -- ARP  -- TCP
//

`default_nettype none
module Vthernet_RX_MAC (
    input   wire        rst,
    
    // CSRs
    input   wire [47:0] my_mac_addr,
    input   wire [15:0] ethernet_len_type,
    output  reg  [47:0] dst_mac_addr,
    output  reg  [47:0] src_mac_addr,

    // CPU interface
    output  reg         rx_irq,

    // GMII interface
    input   wire        RX_CLK,
    input   wire        RX_DV,
    input   wire [7:0]  RXD,
    input   wire        RX_ER,

    // Memory interface
    output  reg         rx_mem_wen,
    output  reg  [7:0]  rx_mem_data,
    output  reg  [31:0] rx_mem_addr
);
    parameter OCT   = 8;
    parameter PRE   = 8'b10101010;
    parameter SFD   = 8'b10101011;
    parameter IPV4  = 16'h0800;

    // RX Memory logic
    // SMI logic
    // transmit logic
    // receive logic
    wire                rx_ethernet_data_v;
    wire    [OCT-1:0]   rx_ethernet_data;

    // receive irq signal
    wire                rx_ethernet_irq;

    rx_ethernet #(
        .OCT    (OCT    ),
        .PRE    (PRE    ),
        .SFD    (SFD    ),
        .IPV4   (IPV4   )
    ) rx_ethernet_inst(
        .rst            (rst        ),

        // CSRs
        .my_mac_addr        (my_mac_addr        ),
        .ethernet_len_type  (ethernet_len_type  ),
        .dst_mac_addr       (dst_mac_addr       ),
        .src_mac_addr       (src_mac_addr       ),

        // CPU interface
        .rx_ethernet_irq    (rx_ethernet_irq   ),

        // GMII interface
        .RX_CLK         (RX_CLK     ),
        .RX_DV          (RX_DV      ),
        .RXD            (RXD        ),
        .RX_ER          (RX_ER      ),

        // Memory interface
        .rx_ethernet_data_v (rx_ethernet_data_v ),
        .rx_ethernet_data   (rx_ethernet_data   )
    );

endmodule
`default_nettype wire
