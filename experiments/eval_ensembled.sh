mem_channels=1
dram_io=4800
cxl_bw=64000
cxl_latency="[80]"

cd ..

exp_tag=ensemble_explore_0

python run_experiments.py --pref_id 0 --max_threads 64 --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/spec --pf_on_pf --l2_pref="['no']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000
python run_experiments.py --pref_id 0 --max_threads 64 --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/parsec --pf_on_pf --l2_pref="['no']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000
python run_experiments.py --pref_id 0 --max_threads 64 --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/gapbs --pf_on_pf --l2_pref="['no']" --pfb_pre="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=150000000 --sim_inst=50000000

exp_tag=ensemble_explore_1

python run_experiments.py --pref_id 1 --max_threads 64 --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/spec --pf_on_pf --l2_pref="['no']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000
python run_experiments.py --pref_id 1 --max_threads 64 --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/parsec --pf_on_pf --l2_pref="['no']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000
python run_experiments.py --pref_id 1 --max_threads 64 --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/gapbs --pf_on_pf --l2_pref="['no']" --pfb_pre="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=150000000 --sim_inst=50000000

exp_tag=ensemble_explore_2

python run_experiments.py --pref_id 2 --max_threads 64 --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/spec --pf_on_pf --l2_pref="['no']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000
python run_experiments.py --pref_id 2 --max_threads 64 --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/parsec --pf_on_pf --l2_pref="['no']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000
python run_experiments.py --pref_id 2 --max_threads 64 --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/gapbs --pf_on_pf --l2_pref="['no']" --pfb_pre="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=150000000 --sim_inst=50000000

exp_tag=ensemble_explore_3

python run_experiments.py --pref_id 3 --max_threads 64 --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/spec --pf_on_pf --l2_pref="['no']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000
python run_experiments.py --pref_id 3 --max_threads 64 --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/parsec --pf_on_pf --l2_pref="['no']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000
python run_experiments.py --pref_id 3 --max_threads 64 --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/gapbs --pf_on_pf --l2_pref="['no']" --pfb_pre="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=150000000 --sim_inst=50000000
