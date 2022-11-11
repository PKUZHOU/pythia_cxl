import os
import random
cores = 16
n_tasks = 16
traces_dir = "../../traces/"
benchmarks = ['gapbs','parsec','spec']
all_traces = []
random.seed(0)
for benchmark in benchmarks:
    bench_dir = os.path.join(traces_dir, benchmark)
    traces = os.listdir(bench_dir)
    for trace in traces:
        all_traces.append(os.path.join(benchmark, trace))

for task_id in range(n_tasks):
    sampled_tasks = random.sample(all_traces, cores)
    print(sampled_tasks)
