mem_channels=1
dram_io=4800
cxl_bw=64000
cxl_latency="[80]"

cd ..
exp_tag=pfb_512
python run_experiments.py --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/spec_select --pfb_sets 512 --pf_on_pf --l2_pref="['no', 'bop','streamer','scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000
exp_tag=pfb_1024
python run_experiments.py --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/spec_select --pfb_sets 1024 --pf_on_pf --l2_pref="['no', 'bop','streamer','scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000 
exp_tag=pfb_2048
python run_experiments.py --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/spec_select --pfb_sets 2048 --pf_on_pf --l2_pref="['no', 'bop','streamer','scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000
exp_tag=pfb_4096
python run_experiments.py --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/spec_select --pfb_sets 4096 --pf_on_pf --l2_pref="['no', 'bop','streamer','scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000
exp_tag=pfb_8192
python run_experiments.py --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/spec_select --pfb_sets 8192 --pf_on_pf --l2_pref="['no', 'bop','streamer','scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000