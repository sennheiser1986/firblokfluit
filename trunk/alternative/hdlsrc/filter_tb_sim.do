onbreak resume
onerror resume
vsim work.filter_tb
add wave sim:/filter_tb/u_filter/ready
add wave sim:/filter_tb/u_filter/clk_en
add wave sim:/filter_tb/u_filter/reset_n
add wave sim:/filter_tb/u_filter/R_i
add wave sim:/filter_tb/u_filter/filter_out
add wave sim:/filter_tb/filter_out_ref
run -all
