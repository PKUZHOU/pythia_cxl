exp_tag=explore_latency
mem_channels=1
dram_io=4800
cxl_bw=64000
cxl_latency="[40,80,120,160,200]"

cd ..
python run_experiments.py --max_threads   --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/spec --pf_on_pf --l2_pref="['no','scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=30000000 --sim_inst=50000000
python run_experiments.py --max_threads   --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/parsec --pf_on_pf --l2_pref="['no','scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=30000000 --sim_inst=50000000
python run_experiments.py --max_threads   --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/gapbs --pf_on_pf --l2_pref="['no','scooby']" --pfb_pre="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=150000000 --sim_inst=30000000

python run_experiments.py --max_threads   --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/spec --l2_pref="['no','scooby']" --pfb_pref="['no']" --enable_cxl --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=30000000 --sim_inst=50000000
python run_experiments.py --max_threads   --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/parsec --l2_pref="['no','scooby']" --pfb_pref="['no']" --enable_cxl --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=30000000 --sim_inst=50000000
python run_experiments.py --max_threads   --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/gapbs --l2_pref="['no','scooby']" --pfb_pre="['no']" --enable_cxl --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=150000000 --sim_inst=30000000

python run_experiments.py --max_threads   --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/spec  --l2_pref="['no','scooby']" --pfb_pref="['hybrid_active']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=30000000 --sim_inst=50000000
python run_experiments.py --max_threads   --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/parsec  --l2_pref="['no','scooby']" --pfb_pref="['hybrid_active']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=30000000 --sim_inst=50000000
python run_experiments.py --max_threads   --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/gapbs  --l2_pref="['no','scooby']" --pfb_pre="['hybrid_active']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=150000000 --sim_inst=30000000
