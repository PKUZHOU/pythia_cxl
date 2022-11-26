cxl_latency="[80]"
num_cores=1
mem_channels=1
cxl_bw=6000

cd ..

exp_tag=bandwidth_1.0_4000

dram_io=500
python run_experiments.py --exp_tag $exp_tag --trace_dir ./traces/gapbs --results_dir ./experiments/isca/  --pf_on_pf --l2_pref="['scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=150000000 --sim_inst=50000000  --num_cores=$num_cores

exp_tag=bandwidth_1.5_4000
dram_io=750
python run_experiments.py --exp_tag $exp_tag  --trace_dir ./traces/gapbs --results_dir ./experiments/isca/ --pf_on_pf --l2_pref="['scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=150000000 --sim_inst=50000000  --num_cores=$num_cores

exp_tag=bandwidth_2.0_4000
dram_io=1000
python run_experiments.py --exp_tag $exp_tag --trace_dir ./traces/gapbs --results_dir ./experiments/isca/  --pf_on_pf --l2_pref="['scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=150000000 --sim_inst=50000000  --num_cores=$num_cores

exp_tag=bandwidth_2.5_4000
dram_io=1250
python run_experiments.py --exp_tag $exp_tag --trace_dir ./traces/gapbs --results_dir ./experiments/isca/  --pf_on_pf --l2_pref="['scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=150000000 --sim_inst=50000000  --num_cores=$num_cores




