exp_tag=baseline_4C
mem_channels=2
num_cores=4
dram_io=4800
cxl_bw=64000

cd ..
python run_experiments.py --enable_cxl --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/  --l2_pref="['no', 'bop_new','streamer','scooby']" --pfb_pref="['no']" --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000 --num_cores=$num_cores

