mem_channels=1
dram_io=4800
cxl_bw=64000
cxl_latency="[80]"
cpu_degree=1

exp_tag=explore_cpu_deg_spec_$cpu_degree

cd ..
python run_exploration.py --pf_on_pf  --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/spec_select  --l2_pref="['scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000

python dump_results.py --exp_tag $exp_tag 