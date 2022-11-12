exp_tag=neomem_opt_1C_no_pf_active_deg4
mem_channels=1
dram_io=4800
cxl_bw=64000
cxl_latency="[80]"
active_degree=4
active_thresh=0.02

cd ..
python run_experiments.py --active_degree $active_degree --active_threshold $active_thresh --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/spec  --l2_pref="['no', 'bop_new','streamer','scooby']" --pfb_pref="['hybrid_active']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000
python run_experiments.py --active_degree $active_degree --active_threshold $active_thresh --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/parsec  --l2_pref="['no','bop_new', 'streamer', 'scooby']" --pfb_pref="['hybrid_active']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000
python run_experiments.py --active_degree $active_degree --active_threshold $active_thresh --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/gapbs  --l2_pref="['no','bop_new', 'streamer', 'scooby']" --pfb_pre="['hybrid_active']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=150000000 --sim_inst=50000000

