exp_tag=neomem_opt_ddio_4C_deg2_front
mem_channels=2
dram_io=4800
cxl_bw=64000
cxl_latency="[80]"
num_cores=4
active_degree=2

cd ..
python run_experiments.py  --pf_on_pf  --exp_tag $exp_tag  --active_degree=$active_degree --results_dir ./experiments/isca/ --trace_dir ./traces/  --l2_pref="['no', 'bop_new','streamer','scooby']" --pfb_pref="['hybrid_active']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000  --num_cores=$num_cores

python dump_results.py --num_cores=$num_cores --exp_tag $exp_tag 