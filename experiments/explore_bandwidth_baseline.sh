mem_channels=2
cxl_bw=64000
cxl_latency="[80]"
num_cores=4

cd ..

exp_tag=bandwidth_4800_baseline
dram_io=4800
python run_experiments.py --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/  --l2_pref="['scooby']"  --enable_cxl  --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000  --num_cores=$num_cores

exp_tag=bandwidth_6400_baseline
dram_io=6400
python run_experiments.py --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/  --l2_pref="['scooby']"  --enable_cxl  --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000  --num_cores=$num_cores

exp_tag=bandwidth_4800_4c_baseline
dram_io=4800
mem_channels=4
python run_experiments.py --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/  --l2_pref="['scooby']"  --enable_cxl  --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000  --num_cores=$num_cores

exp_tag=bandwidth_6400_4c_baseline
dram_io=6400
mem_channels=4
python run_experiments.py --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/  --l2_pref="['scooby']"  --enable_cxl  --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000  --num_cores=$num_cores




