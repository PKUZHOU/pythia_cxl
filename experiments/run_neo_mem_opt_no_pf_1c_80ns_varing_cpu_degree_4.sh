exp_tag=neomem_opt_1C_no_pf_cpu_degree_4
mem_channels=1
dram_io=4800
cxl_bw=64000
cxl_latency="[80]"

cd ..
python run_experiments.py --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/spec_select  --l2_pref="['bop_new','streamer','scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000
python dump_results.py --exp_tag $exp_tag 

exp_tag=neomem_opt_1C_cpu_degree_4

python run_experiments.py --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/spec_select --pf_on_pf --l2_pref="['bop_new','streamer','scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000
python dump_results.py --exp_tag $exp_tag 