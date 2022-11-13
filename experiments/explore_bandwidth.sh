cxl_bw=64000
cxl_latency="[80]"
num_cores=4

cd ..

exp_tag=bandwidth_4800_2ch
dram_io=4800
mem_channels=2
nohup  python run_experiments.py --pfb_degree 10 --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/ --pf_on_pf --l2_pref="['scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000  --num_cores=$num_cores &

exp_tag=bandwidth_6400_2ch
dram_io=6400
mem_channels=2
nohup  python run_experiments.py --pfb_degree 12 --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/ --pf_on_pf --l2_pref="['scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000  --num_cores=$num_cores &

exp_tag=bandwidth_4800_4ch
dram_io=4800
mem_channels=4
nohup  python run_experiments.py --pfb_degree 16 --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/ --pf_on_pf --l2_pref="['scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000  --num_cores=$num_cores &

exp_tag=bandwidth_6400_4ch
dram_io=6400
mem_channels=4
nohup  python run_experiments.py --pfb_degree 20 --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/ --pf_on_pf --l2_pref="['scooby']" --pfb_pref="['hybrid']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=50000000 --sim_inst=50000000  --num_cores=$num_cores &




