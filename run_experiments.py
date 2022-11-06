import argparse
import os
import json
import threading
from itertools import product
import time 

DEBUG = False

def parse_args():
    parser = argparse.ArgumentParser(description='Experiments')
    parser.add_argument('--exp_tag', type=str, default='short_cut_v2', help='the purpose of this experiment')
    parser.add_argument('--max_threads',type=int,default='64')
    parser.add_argument('--trace_dir', type=str, default='./traces/spec_select', help='root directory of trace')
    parser.add_argument('--results_dir', type=str, default='./experiments/isca/', help='root directory to save all results')
    
    parser.add_argument('--l1_pref', type=list, default=['multi'])
    parser.add_argument('--l2_pref', type=list, default=['scooby']) 
    parser.add_argument('--pfb_pref', type=list, default=['hybrid'])

    parser.add_argument('--llc_pref',type=list, default=['no'])

    parser.add_argument('--cfg_def_file', type=str, default="./inc/defines.h")
    parser.add_argument('--enable_cxl', action="store_true", help="enable cxl channel")
    parser.add_argument('--enable_pfb', action="store_true", help="enable cxl memory prefetch buffer")

    # parser.add_argument('--cxl_latency', type=list, default=[40, 120, 160, 200])
    parser.add_argument('--cxl_latency', type=list, default=[80])
    parser.add_argument('--pfb_latency', type=int, default=20)

    parser.add_argument('--pfb_sets', type=int, default=4096, help='pfb_sets = 1 to simulate CXL without prefetch buffer')
    parser.add_argument('--pfb_ways', type=int, default=16, help='pfb_ways = 1 to simulate CXL without prefetch buffer')

    parser.add_argument('--mem_channels', type=int, default=1, help='the memory channels')
    parser.add_argument('--num_cores', type=int, default=1, help='total cores')
    parser.add_argument('--dram_io', type=int, default=4800)

    parser.add_argument('--branch_predictor', type=str, default="perceptron")
    parser.add_argument('--warmup_inst',type=int, default=50000000, help="gapbs 150m, general 50m")
    parser.add_argument('--sim_inst',type=int, default=100000000, help='gapbs 50m, general 100m')

    args = parser.parse_args()
    return args

def exec_cmd(cmd):
    os.system(cmd)

def parallel_run(args, all_sim_cmds):
    threads = []
    issued_threads = 0
    total_tasks = len(all_sim_cmds)
    while(issued_threads < total_tasks):
        running_threads = 0
        for th in threads:
            if th.is_alive():
                running_threads += 1

        for i in range(args.max_threads - running_threads):
            new_thread_id = issued_threads
            if(new_thread_id < total_tasks):
                th = threading.Thread(target = exec_cmd, args = (all_sim_cmds[new_thread_id],))
                th.start()
                threads.append(th)
                issued_threads += 1

        time.sleep(0.2)
    for th in threads:
        th.join()

def prepare_sim_cmds(args):
    l1_prefs = args.l1_pref
    l2_prefs = args.l2_pref
    llc_prefs = args.llc_pref
    pfb_prefs = args.pfb_pref
    
    all_sim_cmds = []

    if args.enable_cxl == False:
        args.cxl_latency = [0]

    for latency in args.cxl_latency:
        cxl_latency = latency
        if (args.enable_pfb == True):
            pfb_latency = args.pfb_latency
        else:
            pfb_latency = 0
        
        results_dir = os.path.join(args.results_dir, args.exp_tag, str(cxl_latency))
        if(not os.path.exists(results_dir)):
            os.makedirs(results_dir)

        pref_combinations = product(*[l1_prefs, l2_prefs, llc_prefs, pfb_prefs])
        for prefs in pref_combinations:
            pref_comb = "{}-{}-{}-{}".format(*prefs)

            l2_pref = prefs[1]
            pfb_pref = prefs[3]
            l2_pref_config_path = "./config/{}.ini".format(l2_pref)
            pfb_pref_config_path = "./config/{}.ini".format(pfb_pref)

            config_result_dir = os.path.join(results_dir, pref_comb)
            if not os.path.exists(config_result_dir):
                os.makedirs(config_result_dir)
            
            params = []
            #set config
            if (args.enable_cxl):
                params.append("WITH_CXL")
            
            if (args.enable_pfb):
                params.append("WITH_PFB")
                params.append("PFB_SET {}".format(args.pfb_sets))
                params.append("PFB_WAY {}".format(args.pfb_ways))

            params.append("CXL_LATENCY {}".format(cxl_latency))
            params.append("PFB_LATENCY {}".format(pfb_latency))
            # params.append("DRAM_IO_FREQ {}".format(args.dram_io))
            
            with open(args.cfg_def_file,"w") as f:
                for param in params:
                    f.write("#define {}\n".format(param))

            #build binary
            config_cmd = "./build_champsim.sh {l1pref} {l2pref} {llcpref} {pfbpref} {cores}"\
                .format(l1pref = "multi", l2pref = "multi", llcpref = "no", pfbpref = prefs[3],  cores = args.num_cores)
            exec_cmd(config_cmd)
            
            copy_binary_cmd = "cp ./bin/champsim " + config_result_dir
            exec_cmd(copy_binary_cmd)

            copy_cfg_cmd = "cp {} {}".format(args.cfg_def_file, config_result_dir)
            exec_cmd(copy_cfg_cmd)

            args_dump_path = "{}/args.log".format(config_result_dir)
            f = open(args_dump_path, "w")
            f.writelines(str(args))
            f.write("\n\n")

            if args.num_cores == 1:
                for trace in os.listdir(args.trace_dir):
                    # trace_name = trace.split(".")[0]
                    trace_name = trace
                    # trace_name = trace.strip("champsimtrace.xz")
                    trace_path = os.path.join(args.trace_dir, trace)
                    sim_results_path = os.path.join(config_result_dir, trace_name + ".out")

        
                    sim_cmd = "{binary} --warmup_instructions={warmup_inst} --simulation_instructions={sim_inst} ".format(\
                    binary = os.path.join(config_result_dir, "champsim"), warmup_inst = args.warmup_inst, sim_inst = args.sim_inst)                        


                    if l2_pref == "no":
                        sim_cmd += " --config={l2_pref_config}".format(l2_pref_config=l2_pref_config_path)
                    else:
                        sim_cmd += " --l2c_prefetcher_types={l2pref} --config={l2_pref_config}".format( l2pref = l2_pref,  l2_pref_config=l2_pref_config_path)
                    
                    if args.enable_pfb and pfb_pref != "no":
                        sim_cmd += " --config={pfb_pref_config}".format(pfb_pref_config = pfb_pref_config_path)
                    sim_cmd += " -traces {trace_dir} > {results_dir}".format(trace_dir = trace_path, results_dir = sim_results_path)

                    all_sim_cmds.append(sim_cmd)
                    f.write(sim_cmd + "\n")
            else:
                raise NotImplementedError
                # all_traces_cmd = ""
                # trace_name = ""
                # for trace in os.listdir(args.trace_dir):
                #     trace_path = os.path.join(args.trace_dir, trace)
                #     if len(trace_name) == 0: trace_name = trace.split(".")[0]
                #     trace_path = os.path.join(args.trace_dir, trace)
                #     all_traces_cmd+=trace_path
                #     all_traces_cmd+=" "
                # sim_results_path = os.path.join(config_result_dir, trace_name + ".out")
                # sim_cmd = "{binary} --warmup_instructions {warmup_inst} --simulation_instructions {sim_inst} {trace_dir} > {results_dir}".format(\
                #         binary = os.path.join(config_result_dir, "champsim"), warmup_inst = args.warmup_inst, sim_inst = args.sim_inst, trace_dir = all_traces_cmd, results_dir = sim_results_path)
                # all_sim_cmds.append(sim_cmd)

    return all_sim_cmds


def main():
    args = parse_args()
    if not os.path.exists(args.trace_dir):
        print(args.trace_dir, "does not exist!")
    all_sim_cmds = prepare_sim_cmds(args)
    print(all_sim_cmds)
    parallel_run(args, all_sim_cmds)

if __name__ == '__main__':
    main()