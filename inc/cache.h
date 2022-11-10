#ifndef CACHE_H
#define CACHE_H

#include "memory_class.h"
#include "prefetcher.h"


// PAGE
extern uint32_t PAGE_TABLE_LATENCY, SWAP_LATENCY;

// CACHE TYPE
#define IS_ITLB 0
#define IS_DTLB 1
#define IS_STLB 2
#define IS_L1I 3
#define IS_L1D 4
#define IS_L2C 5
#define IS_LLC 6
#define IS_CXL 7
#define IS_PFB 8

// INSTRUCTION TLB
#define ITLB_SET 16
#define ITLB_WAY 8
#define ITLB_RQ_SIZE 16
#define ITLB_WQ_SIZE 16
#define ITLB_PQ_SIZE 0
#define ITLB_MSHR_SIZE 8
#define ITLB_LATENCY 1

// DATA TLB
#define DTLB_SET 16
#define DTLB_WAY 4
#define DTLB_RQ_SIZE 16
#define DTLB_WQ_SIZE 16
#define DTLB_PQ_SIZE 0
#define DTLB_MSHR_SIZE 8
#define DTLB_LATENCY 1

// SECOND LEVEL TLB
#define STLB_SET 128
#define STLB_WAY 12
#define STLB_RQ_SIZE 32
#define STLB_WQ_SIZE 32
#define STLB_PQ_SIZE 0
#define STLB_MSHR_SIZE 16
#define STLB_LATENCY 8

// L1 INSTRUCTION CACHE
#define L1I_SET 64
#define L1I_WAY 8
#define L1I_RQ_SIZE 64
#define L1I_WQ_SIZE 64
#define L1I_PQ_SIZE 8
#define L1I_MSHR_SIZE 8
#define L1I_LATENCY 1

// L1 DATA CACHE
#define L1D_SET 64
#define L1D_WAY 8
#define L1D_RQ_SIZE 64
#define L1D_WQ_SIZE 64
#define L1D_PQ_SIZE 8
#define L1D_MSHR_SIZE 16
#define L1D_LATENCY 4

// L2 CACHE
#define L2C_SET 512
#define L2C_WAY 8
#define L2C_RQ_SIZE 32
#define L2C_WQ_SIZE 32
#define L2C_PQ_SIZE 32
#define L2C_MSHR_SIZE 32
#define L2C_LATENCY 10 // 5 (L1I or L1D) + 10 = 14 cycles

// LAST LEVEL CACHE
#define LLC_SET NUM_CPUS * 2048
#define LLC_WAY 16
#define LLC_RQ_SIZE NUM_CPUS *L2C_MSHR_SIZE // 48
#define LLC_WQ_SIZE NUM_CPUS *L2C_MSHR_SIZE // 48
#define LLC_PQ_SIZE NUM_CPUS * 32
#define LLC_MSHR_SIZE NUM_CPUS * 64
#define LLC_LATENCY 20 // 5 (L1I or L1D) + 10 + 20 = 34 cycles
#define LLC_BW_COMPUTE_EPOCH 100

// Simulate the CXL Channel
#define CXL_SET 1
#define CXL_WAY 1

#ifndef CXL_LATENCY
    #define CXL_LATENCY 1
#endif

#ifndef CXL_BW
    #define CXL_BW 64000
#endif

#define CXL_RQ_SIZE LLC_MSHR_SIZE
#define CXL_WQ_SIZE LLC_MSHR_SIZE
#define CXL_PQ_SIZE LLC_MSHR_SIZE
#define CXL_MSHR_SIZE LLC_MSHR_SIZE
#define CXL_BW_COMPUTE_EPOCH 100

// PFB

#ifndef PFB_SET
    #define PFB_SET 1
#endif

#ifndef PFB_WAY
    #define PFB_WAY 1
#endif

#define PFB_RQ_SIZE CXL_MSHR_SIZE
#define PFB_WQ_SIZE CXL_MSHR_SIZE
#define PFB_PQ_SIZE CXL_MSHR_SIZE
#define PFB_MSHR_SIZE CXL_MSHR_SIZE

#ifndef PFB_LATENCY
    #define PFB_LATENCY 1
#endif

#define PFB_BW_COMPUTE_EPOCH 100

#define CACHE_ACC_LEVELS 10

void print_cache_config();

class CACHE : public MEMORY
{
public:
    uint32_t cpu;
    const string NAME;
    const uint32_t NUM_SET, NUM_WAY, NUM_LINE, WQ_SIZE, RQ_SIZE, PQ_SIZE, MSHR_SIZE;
    uint32_t LATENCY;
    uint64_t BUS_RETURN_TIME;
    BLOCK **block;
    int fill_level;
    uint32_t MAX_READ, MAX_FILL;
    uint32_t reads_available_this_cycle;
    uint8_t cache_type;

    // prefetch stats
    uint64_t pf_requested,
        pf_dropped,
        pf_issued,
        pf_filled,
        pf_useful,
        pf_useless,
        pf_late;

    /* for computing memory subsystem bw */
    uint32_t bw_compute_epoch;

    // queues
    PACKET_QUEUE WQ{NAME + "_WQ", WQ_SIZE},       // write queue
        RQ{NAME + "_RQ", RQ_SIZE},                // read queue
        PQ{NAME + "_PQ", PQ_SIZE},                // prefetch queue
        MSHR{NAME + "_MSHR", MSHR_SIZE},          // MSHR
        PROCESSED{NAME + "_PROCESSED", ROB_SIZE}; // processed queue

    uint64_t sim_access[NUM_CPUS][NUM_TYPES],
        sim_hit[NUM_CPUS][NUM_TYPES],
        sim_miss[NUM_CPUS][NUM_TYPES],
        roi_access[NUM_CPUS][NUM_TYPES],
        roi_hit[NUM_CPUS][NUM_TYPES],
        roi_miss[NUM_CPUS][NUM_TYPES];

    uint64_t total_miss_latency;

    /* Array of prefetchers associated with this cache */
    vector<Prefetcher *> prefetchers;
    vector<Prefetcher *> l1d_prefetchers;

    /* For semi-perfect cache */
    deque<uint64_t> page_buffer;

    /* For cache accuracy measurement */
    uint64_t cycle, next_measure_cycle;
    uint64_t pf_useful_epoch, pf_filled_epoch;
    uint32_t pref_acc;
    uint64_t total_acc_epochs, acc_epoch_hist[CACHE_ACC_LEVELS];

    uint64_t bus_cycle_available;
    // constructor
    CACHE(string v1, uint32_t v2, int v3, uint32_t v4, uint32_t v5, uint32_t v6, uint32_t v7, uint32_t v8)
        : NAME(v1), NUM_SET(v2), NUM_WAY(v3), NUM_LINE(v4), WQ_SIZE(v5), RQ_SIZE(v6), PQ_SIZE(v7), MSHR_SIZE(v8)
    {

        LATENCY = 0;
        BUS_RETURN_TIME = 0;
        // cache block
        block = new BLOCK *[NUM_SET];
        for (uint32_t i = 0; i < NUM_SET; i++)
        {
            block[i] = new BLOCK[NUM_WAY];

            for (uint32_t j = 0; j < NUM_WAY; j++)
            {
                block[i][j].lru = j;
            }
        }

        for (uint32_t i = 0; i < NUM_CPUS; i++)
        {
            upper_level_icache[i] = NULL;
            upper_level_dcache[i] = NULL;

            for (uint32_t j = 0; j < NUM_TYPES; j++)
            {
                sim_access[i][j] = 0;
                sim_hit[i][j] = 0;
                sim_miss[i][j] = 0;
                roi_access[i][j] = 0;
                roi_hit[i][j] = 0;
                roi_miss[i][j] = 0;
            }
        }

        total_miss_latency = 0;

        lower_level = NULL;
        extra_interface = NULL;
        fill_level = -1;
        MAX_READ = 1;
        MAX_FILL = 1;

        pf_requested = 0;
        pf_dropped = 0;
        pf_issued = 0;
        pf_filled = 0;
        pf_useful = 0;
        pf_useless = 0;
        pf_late = 0;

        cycle = 0;
        next_measure_cycle = 0;
        pf_useful_epoch = 0;
        pf_filled_epoch = 0;
        pref_acc = 0;
        total_acc_epochs = 0;
        bus_cycle_available = 0;
        bw_compute_epoch = 0;
    };

    // destructor
    ~CACHE()
    {
        for (uint32_t i = 0; i < NUM_SET; i++)
            delete[] block[i];
        delete[] block;
    };

    // functions
    int add_rq(PACKET *packet),
        add_wq(PACKET *packet),
        add_pq(PACKET *packet);

    void return_data(PACKET *packet),
        operate(),
        increment_WQ_FULL(uint64_t address);

    uint32_t get_occupancy(uint8_t queue_type, uint64_t address),
        get_size(uint8_t queue_type, uint64_t address);

    int check_hit(PACKET *packet),
        invalidate_entry(uint64_t inval_addr),
        check_mshr(PACKET *packet),
        prefetch_line(uint64_t ip, uint64_t base_addr, uint64_t pf_addr, int prefetch_fill_level, uint32_t prefetch_metadata),
        kpc_prefetch_line(uint64_t base_addr, uint64_t pf_addr, int prefetch_fill_level, int delta, int depth, int signature, int confidence, uint32_t prefetch_metadata);

    void handle_fill(),
        handle_writeback(),
        handle_read(),
        handle_prefetch();

    void add_mshr(PACKET *packet),
        update_fill_cycle(),
        llc_initialize_replacement(),
        pfb_initialize_replacement(),
        update_replacement_state(uint32_t cpu, uint32_t set, uint32_t way, uint64_t full_addr, uint64_t ip, uint64_t victim_addr, uint32_t type, uint8_t hit),
        llc_update_replacement_state(uint32_t cpu, uint32_t set, uint32_t way, uint64_t full_addr, uint64_t ip, uint64_t victim_addr, uint32_t type, uint8_t hit),
        pfb_update_replacement_state(uint32_t cpu, uint32_t set, uint32_t way, uint64_t full_addr, uint64_t ip, uint64_t victim_addr, uint32_t type, uint8_t hit),

        lru_update(uint32_t set, uint32_t way),
        fill_cache(uint32_t set, uint32_t way, PACKET *packet),
        replacement_final_stats(),
        llc_replacement_final_stats(),
        pfb_replacement_final_stats(),

        // prefetcher_initialize(),
        l1d_prefetcher_initialize(),
        l2c_prefetcher_initialize(),
        llc_prefetcher_initialize(),
        pfb_prefetcher_initialize(),

        l1d_prefetcher_print_config(),
        l2c_prefetcher_print_config(),
        llc_prefetcher_print_config(),
        pfb_prefetcher_print_config(),

        prefetcher_operate(uint64_t addr, uint64_t ip, uint8_t cache_hit, uint8_t type),
        l1d_prefetcher_operate(uint64_t addr, uint64_t ip, uint8_t cache_hit, uint8_t type),
        prefetcher_cache_fill(uint64_t addr, uint32_t set, uint32_t way, uint8_t prefetch, uint64_t evicted_addr),
        l1d_prefetcher_cache_fill(uint64_t addr, uint32_t set, uint32_t way, uint8_t prefetch, uint64_t evicted_addr, uint32_t metadata_in),
        // prefetcher_final_stats(),
        l1d_prefetcher_final_stats(),
        l2c_prefetcher_final_stats(),
        llc_prefetcher_final_stats(),
        pfb_prefetcher_final_stats();

    uint32_t l1d_prefetcher_prefetch_hit(uint64_t addr, uint64_t ip, uint32_t metadata_in),
        l2c_prefetcher_prefetch_hit(uint64_t addr, uint64_t ip, uint32_t metadata_in),
        llc_prefetcher_prefetch_hit(uint64_t addr, uint64_t ip, uint32_t metadata_in),
        pfb_prefetcher_prefetch_hit(uint64_t addr, uint64_t ip, uint32_t metadata_in);

    uint32_t l2c_prefetcher_operate(uint64_t addr, uint64_t ip, uint8_t cache_hit, uint8_t type, uint32_t metadata_in),
        llc_prefetcher_operate(uint64_t addr, uint64_t ip, uint8_t cache_hit, uint8_t type, uint32_t metadata_in),
        pfb_prefetcher_operate(uint64_t addr, uint64_t ip, uint8_t cache_hit, uint8_t type, uint32_t metadata_in),

        l2c_prefetcher_cache_fill(uint64_t addr, uint32_t set, uint32_t way, uint8_t prefetch, uint64_t evicted_addr, uint32_t metadata_in),
        llc_prefetcher_cache_fill(uint64_t addr, uint32_t set, uint32_t way, uint8_t prefetch, uint64_t evicted_addr, uint32_t metadata_in),
        pfb_prefetcher_cache_fill(uint64_t addr, uint32_t set, uint32_t way, uint8_t prefetch, uint64_t evicted_addr, uint32_t metadata_in);

    void broadcast_bw(uint8_t bw_level),
        l1d_prefetcher_broadcast_bw(uint8_t bw_level),
        l2c_prefetcher_broadcast_bw(uint8_t bw_level),
        llc_prefetcher_broadcast_bw(uint8_t bw_level),
        pfb_prefetcher_broadcast_bw(uint8_t bw_level);

    void broadcast_ipc(uint8_t ipc),
        l1d_prefetcher_broadcast_ipc(uint8_t ipc),
        l2c_prefetcher_broadcast_ipc(uint8_t ipc),
        llc_prefetcher_broadcast_ipc(uint8_t ipc),
        pfb_prefetcher_broadcast_ipc(uint8_t ipc);

    void prefetcher_feedback(uint64_t &pref_gen, uint64_t &pref_fill, uint64_t &pref_used, uint64_t &pref_late);

    uint32_t get_set(uint64_t address),
        get_way(uint64_t address, uint32_t set),
        find_victim(uint32_t cpu, uint64_t instr_id, uint32_t set, const BLOCK *current_set, uint64_t ip, uint64_t full_addr, uint32_t type),
        llc_find_victim(uint32_t cpu, uint64_t instr_id, uint32_t set, const BLOCK *current_set, uint64_t ip, uint64_t full_addr, uint32_t type),
        pfb_find_victim(uint32_t cpu, uint64_t instr_id, uint32_t set, const BLOCK *current_set, uint64_t ip, uint64_t full_addr, uint32_t type),
        lru_victim(uint32_t cpu, uint64_t instr_id, uint32_t set, const BLOCK *current_set, uint64_t ip, uint64_t full_addr, uint32_t type);

    bool search_and_add(uint64_t page);

    void handle_prefetch_feedback();
    void broadcast_acc(uint32_t acc_level),
        l1d_prefetcher_broadcast_acc(uint32_t bw_level),
        l2c_prefetcher_broadcast_acc(uint32_t bw_level),
        llc_prefetcher_broadcast_acc(uint32_t bw_level),
        pfb_prefetcher_broadcast_acc(uint32_t bw_level);
};

#endif
