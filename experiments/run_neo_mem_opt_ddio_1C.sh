exp_tag=neomem_opt_1C_ddio
mem_channels=1
dram_io=4800
cxl_bw=64000
cxl_latency="[80]"
active_degree=10
cd ..
# python run_experiments.py --pf_on_pf --exp_tag $exp_tag --active_degree=$active_degree --results_dir ./experiments/isca/ --trace_dir ./traces/parsec  --l2_pref="['bop_new', 'streamer', 'scooby']" --pfb_pref="['hybrid_active']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000
python run_experiments.py --pf_on_pf --exp_tag $exp_tag --active_degree=$active_degree --results_dir ./experiments/isca/ --trace_dir ./traces/gapbs  --l2_pref="['no','bop_new', 'streamer', 'scooby']" --pfb_pre="['hybrid_active']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=150000000 --sim_inst=50000000
python run_experiments.py --pf_on_pf --exp_tag $exp_tag --active_degree=$active_degree --results_dir ./experiments/isca/ --trace_dir ./traces/spec  --l2_pref="['no',bop_new','streamer','scooby']" --pfb_pref="['hybrid_active']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000
python run_experiments.py --pf_on_pf --exp_tag $exp_tag --active_degree=$active_degree --results_dir ./experiments/isca/ --trace_dir ./traces/parsec  --l2_pref="['no']" --pfb_pref="['hybrid_active']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000


