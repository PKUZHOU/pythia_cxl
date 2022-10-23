#ifndef UNCORE_H
#define UNCORE_H

#include "champsim.h"
#include "cache.h"
#include "dram_controller.h"
//#include "drc_controller.h"

//#define DRC_MSHR_SIZE 48

// uncore
class UNCORE {
  public:

    // LLC
    CACHE LLC{"LLC", LLC_SET, LLC_WAY, LLC_SET*LLC_WAY, LLC_WQ_SIZE, LLC_RQ_SIZE, LLC_PQ_SIZE, LLC_MSHR_SIZE};    


#ifdef WITH_PFB
    // PFB
    CACHE PFB{"PFB", PFB_SET, PFB_WAY, PFB_SET*PFB_WAY, PFB_WQ_SIZE, PFB_RQ_SIZE, PFB_PQ_SIZE, PFB_MSHR_SIZE};
#endif

#ifdef WITH_CXL
    CACHE CXL{"CXL", CXL_SET, CXL_WAY, CXL_SET*CXL_WAY, CXL_WQ_SIZE, CXL_RQ_SIZE, CXL_PQ_SIZE, CXL_MSHR_SIZE};
#endif

    // DRAM
    MEMORY_CONTROLLER DRAM{"DRAM"}; 

    // cycle
    uint64_t cycle;

    UNCORE(); 
};

extern UNCORE uncore;

#endif
