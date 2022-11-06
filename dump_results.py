import os
import csv
import argparse


def parse_args():
    parser = argparse.ArgumentParser(description='Experiments')
    parser.add_argument('--exp_tag', type=str, default='no_pf_on_pf',
                        help='the purpose of this experiment')
    parser.add_argument('--filter_list', type=str, default='./filter_list')
    parser.add_argument('--results_dir', type=str, default='./experiments/isca/',
                        help='root directory to save all results')
    parser.add_argument('--csv_dir', type=str, default='./csv_results')

    args = parser.parse_args()
    return args


def run(args):
    out_dir = os.path.join(args.results_dir, args.exp_tag)
    latency_configs = os.listdir(out_dir)
    latency_configs = sorted([int(x) for x in latency_configs])
    csv_save_path = "csv_results/{}".format(args.exp_tag)
    if not os.path.exists(csv_save_path):
        os.mkdir(csv_save_path)

    tasks = ['ipc', 'coverage', 'overpred', 'pfb_load_hit','dram_bw_0','dram_bw_1','dram_bw_2','dram_bw_3']

    target_traces = []
    print(args.filter_list)
    f = open("./filter_list.txt",'r')
    traces = f.readlines()
    for trace in traces:
        target_traces.append(trace.strip())
    f.close()

    for task in tasks:
        f = open('csv_results/{}/{}.csv'.format(args.exp_tag, task),
                 'w', encoding='utf-8')
        csv_writer = csv.writer(f)

        for latency_config in latency_configs:
            latency_config = str(latency_config)
            # print(latency_config)
            csv_writer.writerow([latency_config])
            all_results = {}  # save the table data
            results_dir = os.path.join(args.results_dir, args.exp_tag, latency_config)
            configs = os.listdir(results_dir)
            for config in configs:  # different prefetching configurations
                all_results[config] = {}
                config_path = os.path.join(results_dir, config)
                files = os.listdir(config_path)  # different traces
                results = []
                for x in files:
                    if ".out" in x:
                        results.append(x)
                sorted(results)
                for result_file in results:
                    task_name = result_file.split("champsimtrace.xz")[0]
                    # if not task_name in target_traces:
                    #     continue
                    file_path = os.path.join(config_path, result_file)
                    print(file_path)
                    with open(file_path, 'r') as f2:
                        lines = f2.readlines()
                        if task == 'ipc':
                            for line in lines:
                                if "Core_0_IPC" in line:
                                    ipc = line.split(" ")[1].strip()
                                    all_results[config][task_name] = ipc
                                    print(ipc)

                        elif task == 'coverage':
                            for line in lines:
                                if "Core_0_LLC_load_miss" in line:
                                    llc_load_miss = line.split(" ")[1].strip()
                                    all_results[config][task_name] = llc_load_miss

                        elif task == 'overpred':
                            llc_read_miss = 0
                            llc_total_miss = 0
                            llc_write_miss = 0
                            llc_rfo_miss = 0
                            for line in lines:
                                if "Core_0_LLC_total_miss" in line:
                                    llc_total_miss = int(
                                        line.split(" ")[1].strip())
                                if "Core_0_LLC_writeback_miss" in line:
                                    llc_write_miss = int(
                                        line.split(" ")[1].strip())
                                if "Core_0_LLC_RFO_miss" in line:
                                    llc_rfo_miss = int(
                                        line.split(" ")[1].strip())
                            llc_read_miss = llc_total_miss - llc_write_miss - llc_rfo_miss
                            all_results[config][task_name] = llc_read_miss
                        elif task == 'pfb_load_hit':
                            pfb_load_hit = 0
                            for line in lines:
                                if "Core_0_PFB_load_hit" in line:
                                    pfb_load_hit = int(
                                        line.split(" ")[1].strip())
                            all_results[config][task_name] = pfb_load_hit
                        elif task == 'lateness':
                            lateness = 0
                            prefetch_late = 0
                            prefetch_useful = 0
                            for line in lines:
                                if "Core_0_L2C_prefetch_late" in line:
                                    prefetch_late = int(
                                        line.split(" ")[1].strip())

                                if "Core_0_L2C_prefetch_useful" in line:
                                    prefetch_useful = int(
                                        line.split(" ")[1].strip())
                            lateness = float(prefetch_late) / prefetch_useful
                            all_results[config][task_name] = lateness
                        elif task == 'dram_bw_0':
                            for line in lines:
                                if "DRAM_bw_level_0" in line:
                                    bw_level = int(
                                        line.split(" ")[1].strip())
                            all_results[config][task_name] = bw_level
                        elif task == 'dram_bw_1':
                            for line in lines:
                                if "DRAM_bw_level_1" in line:
                                    bw_level = int(
                                        line.split(" ")[1].strip())
                            all_results[config][task_name] = bw_level
                        elif task == 'dram_bw_2':
                            for line in lines:
                                if "DRAM_bw_level_2" in line:
                                    bw_level = int(
                                        line.split(" ")[1].strip())
                            all_results[config][task_name] = bw_level
                        elif task == 'dram_bw_3':
                            for line in lines:
                                if "DRAM_bw_level_3" in line:
                                    bw_level = int(
                                        line.split(" ")[1].strip())
                            all_results[config][task_name] = bw_level

            total_tasks = list(list(all_results.values())[0].keys())
            total_configs = sorted(list(all_results.keys()))

            csv_writer.writerow([' '] + total_tasks)
            for config in total_configs:
                row = []
                for task_name in total_tasks:
                    if task_name in all_results[config].keys():
                        row.append(all_results[config][task_name])
                    else:
                        row.append(0)
                # row = [all_results[config][task] for task in total_tasks]
                row.insert(0, config)
                csv_writer.writerow(row)

        f.close()


def main():
    args = parse_args()
    run(args)


if __name__ == '__main__':
    main()
