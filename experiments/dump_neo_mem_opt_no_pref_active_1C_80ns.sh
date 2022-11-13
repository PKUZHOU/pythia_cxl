exp_tag=neomem_opt_1C_no_pf_active

cd ..
python dump_results.py --exp_tag $exp_tag --filter_list=./traces/gapbs.txt --subset gapbs
python dump_results.py --exp_tag $exp_tag --filter_list=./traces/parsec.txt --subset parsec
python dump_results.py --exp_tag $exp_tag --filter_list=./traces/spec2006.txt --subset spec2006
python dump_results.py --exp_tag $exp_tag --filter_list=./traces/spec2017.txt --subset spec2017
python dump_results.py --exp_tag $exp_tag 