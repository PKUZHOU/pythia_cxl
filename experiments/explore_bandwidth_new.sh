cxl_latency="[80]"
num_cores=1
mem_channels=1
cxl_bw=8000

cd ..

exp_tag=bandwidth_1.0

dram_io=1000
python run_experiments.py --exp_tag $exp_tag --trace_dir ./traces/parsec --results_dir ./experiments/isca/  --pf_on_pf --l2_pref="['scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000  --num_cores=$num_cores

exp_tag=bandwidth_1.5
dram_io=1500
python run_experiments.py --exp_tag $exp_tag  --trace_dir ./traces/parsec --results_dir ./experiments/isca/ --pf_on_pf --l2_pref="['scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000  --num_cores=$num_cores

exp_tag=bandwidth_2.0
dram_io=2000
python run_experiments.py --exp_tag $exp_tag --trace_dir ./traces/parsec --results_dir ./experiments/isca/  --pf_on_pf --l2_pref="['scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000  --num_cores=$num_cores

exp_tag=bandwidth_2.5
dram_io=2500
python run_experiments.py --exp_tag $exp_tag --trace_dir ./traces/parsec --results_dir ./experiments/isca/  --pf_on_pf --l2_pref="['scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000  --num_cores=$num_cores




