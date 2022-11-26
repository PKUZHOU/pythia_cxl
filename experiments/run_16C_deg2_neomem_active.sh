exp_tag=cpu_deg2_16C_neomem_active_80ns
mem_channels=4
dram_io=4800
cxl_bw=128000
cxl_latency="[80]"
num_cores=16
active_degree=4

cd ..
python run_experiments.py  --pf_on_pf  --exp_tag $exp_tag  --active_degree=$active_degree --results_dir ./experiments/isca/ --trace_dir ./traces/  --l2_pref="['scooby','streamer','bop_new','no']" --pfb_pref="['hybrid_active']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=10000000 --sim_inst=10000000  --num_cores=$num_cores

python dump_results.py --num_cores=$num_cores --exp_tag $exp_tag 