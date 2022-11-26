exp_tag=explore_active_params_new_pf_on_pf
mem_channels=1
dram_io=4800
cxl_bw=64000
cxl_latency="[80]"

cd ..
python run_exploration.py --pf_on_pf --exp_tag $exp_tag  --results_dir ./experiments/isca/ --trace_dir ./traces/parsec  --l2_pref="['bop_new']" --pfb_pref="['hybrid_active']" --enable_cxl --enable_pfb --cxl_latency=$cxl_latency --dram_io=$dram_io --mem_channels=$mem_channels --warmup_inst=100000000 --sim_inst=100000000

python dump_results.py --exp_tag $exp_tag --filter_list=./traces/gapbs.txt --subset gapbs
python dump_results.py --exp_tag $exp_tag --filter_list=./traces/parsec.txt --subset parsec
python dump_results.py --exp_tag $exp_tag --filter_list=./traces/spec2006.txt --subset spec2006
python dump_results.py --exp_tag $exp_tag --filter_list=./traces/spec2017.txt --subset spec2017
python dump_results.py --exp_tag $exp_tag 