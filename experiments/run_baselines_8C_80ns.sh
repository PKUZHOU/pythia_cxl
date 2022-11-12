exp_tag=baseline_4C
mem_channels=4
num_cores=8
dram_io=4800
cxl_bw=128000

cd ..
python run_experiments.py --enable_cxl --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/  --l2_pref="['no', 'bop_new','streamer','scooby']" --pfb_pref="['no']" --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000 --num_cores=$num_cores

