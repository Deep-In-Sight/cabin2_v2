set_property INTERNAL_VREF 0.6 [get_iobanks 35]

set_property -dict {PACKAGE_PIN J19 IOSTANDARD HSUL_12} [get_ports mipi_phy_if_0_clk_lp_n]
set_property -dict {PACKAGE_PIN H20 IOSTANDARD HSUL_12} [get_ports mipi_phy_if_0_clk_lp_p]

set_property -dict {PACKAGE_PIN M18 IOSTANDARD HSUL_12} [get_ports {mipi_phy_if_0_data_lp_n[0]}]
set_property -dict {PACKAGE_PIN L19 IOSTANDARD HSUL_12} [get_ports {mipi_phy_if_0_data_lp_p[0]}]
set_property -dict {PACKAGE_PIN L20 IOSTANDARD HSUL_12} [get_ports {mipi_phy_if_0_data_lp_n[1]}]
set_property -dict {PACKAGE_PIN J20 IOSTANDARD HSUL_12} [get_ports {mipi_phy_if_0_data_lp_p[1]}]

set_property -dict {PACKAGE_PIN H18 IOSTANDARD LVDS_25} [get_ports mipi_phy_if_0_clk_hs_n]
set_property -dict {PACKAGE_PIN J18 IOSTANDARD LVDS_25} [get_ports mipi_phy_if_0_clk_hs_p]

set_property -dict {PACKAGE_PIN M20 IOSTANDARD LVDS_25} [get_ports {mipi_phy_if_0_data_hs_n[0]}]
set_property -dict {PACKAGE_PIN M19 IOSTANDARD LVDS_25} [get_ports {mipi_phy_if_0_data_hs_p[0]}]
set_property -dict {PACKAGE_PIN L17 IOSTANDARD LVDS_25} [get_ports {mipi_phy_if_0_data_hs_n[1]}]
set_property -dict {PACKAGE_PIN L16 IOSTANDARD LVDS_25} [get_ports {mipi_phy_if_0_data_hs_p[1]}]

#set_property -dict {PACKAGE_PIN F20 IOSTANDARD LVCMOS33} [get_ports cam_iic_scl_io]
#set_property -dict {PACKAGE_PIN F19 IOSTANDARD LVCMOS33} [get_ports cam_iic_sda_io]

set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets clk]
