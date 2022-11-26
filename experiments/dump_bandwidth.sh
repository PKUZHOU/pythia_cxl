cd ..
python dump_results.py --exp_tag bandwidth_1.0_4000 --filter_list=./traces/gapbs.txt --subset gapbs
python dump_results.py --exp_tag bandwidth_1.0_4000 --filter_list=./traces/parsec.txt --subset parsec

python dump_results.py --exp_tag bandwidth_1.0_baseline_4000 --filter_list=./traces/gapbs.txt --subset gapbs
python dump_results.py --exp_tag bandwidth_1.0_baseline_4000 --filter_list=./traces/parsec.txt --subset parsec

python dump_results.py --exp_tag bandwidth_1.5_4000 --filter_list=./traces/gapbs.txt --subset gapbs
python dump_results.py --exp_tag bandwidth_1.5_4000 --filter_list=./traces/parsec.txt --subset parsec

python dump_results.py --exp_tag bandwidth_1.5_baseline_4000 --filter_list=./traces/gapbs.txt --subset gapbs
python dump_results.py --exp_tag bandwidth_1.5_baseline_4000 --filter_list=./traces/parsec.txt --subset parsec

python dump_results.py --exp_tag bandwidth_2.0_4000 --filter_list=./traces/gapbs.txt --subset gapbs
python dump_results.py --exp_tag bandwidth_2.0_4000 --filter_list=./traces/parsec.txt --subset parsec

python dump_results.py --exp_tag bandwidth_2.0_baseline_4000 --filter_list=./traces/gapbs.txt --subset gapbs
python dump_results.py --exp_tag bandwidth_2.0_baseline_4000 --filter_list=./traces/parsec.txt --subset parsec


python dump_results.py --exp_tag bandwidth_2.5_4000 --filter_list=./traces/gapbs.txt --subset gapbs
python dump_results.py --exp_tag bandwidth_2.5_4000 --filter_list=./traces/parsec.txt --subset parsec

python dump_results.py --exp_tag bandwidth_2.5_baseline_4000 --filter_list=./traces/gapbs.txt --subset gapbs
python dump_results.py --exp_tag bandwidth_2.5_baseline_4000 --filter_list=./traces/parsec.txt --subset parsec