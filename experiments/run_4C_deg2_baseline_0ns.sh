exp_tag=cpu_deg2_baseline_0ns
mem_channels=2
dram_io=4800
cxl_bw=64000
cxl_latency="[80]"
num_cores=4

cd ..
python run_experiments.py   --exp_tag $exp_tag   --results_dir ./experiments/isca/ --trace_dir ./traces/  --l2_pref="['streamer','bop_new']" --pfb_pref="['no']"  --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=30000000  --num_cores=$num_cores

python dump_results.py --num_cores=$num_cores --exp_tag $exp_tag 