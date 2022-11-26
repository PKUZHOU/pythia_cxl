exp_tag=cpu_deg2_16C_neomem_80ns
mem_channels=4
dram_io=4800
cxl_bw=128000
cxl_latency="[80]"
num_cores=16

cd ..
python run_experiments.py --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/ --pf_on_pf --l2_pref="['no','scooby','streamer','bop_new']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=10000000 --sim_inst=10000000  --num_cores=$num_cores

python dump_results.py --num_cores=$num_cores --exp_tag $exp_tag 