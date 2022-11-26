mem_channels=1
cxl_bw=8000
cxl_latency="[80]"
num_cores=1
mem_channels=1

cd ..

exp_tag=bandwidth_1.0_baseline
dram_io=1000
python run_experiments.py --exp_tag $exp_tag   --results_dir ./experiments/isca/  --trace_dir ./traces/parsec  --l2_pref="['scooby']"  --enable_cxl  --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000  --num_cores=$num_cores

exp_tag=bandwidth_1.5_baseline
dram_io=1500
python run_experiments.py --exp_tag $exp_tag  --results_dir ./experiments/isca/  --trace_dir ./traces/parsec  --l2_pref="['scooby']"  --enable_cxl  --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000  --num_cores=$num_cores

exp_tag=bandwidth_2.0_baseline
dram_io=2000
python run_experiments.py --exp_tag $exp_tag  --results_dir ./experiments/isca/  --trace_dir ./traces/parsec  --l2_pref="['scooby']"  --enable_cxl  --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000  --num_cores=$num_cores

exp_tag=bandwidth_2.5_baseline
dram_io=2500
python run_experiments.py --exp_tag $exp_tag  --results_dir ./experiments/isca/  --trace_dir ./traces/parsec  --l2_pref="['scooby']"  --enable_cxl  --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000  --num_cores=$num_cores




