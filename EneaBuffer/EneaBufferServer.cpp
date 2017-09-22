/*
 * EneaBufferServer.cpp
 *  Created on: 19 mars 2010  Author: Zingo Andersen
 *  License: Public Domain (steal and use what you like)
 *
 *  The Server will create a shared area that the client will then use
 *  The server will initiate the first int in the area and print it's value every
 *  5s. If you start the client in parallell it will try to change this value
 *  (value=value+1).
 */


#include "IEneaBuffer.h"
#include <binder/MemoryHeapBase.h>
#include <binder/IServiceManager.h>
#include <binder/IPCThreadState.h>

namespace android { 
#define MEMORY_SIZE 10*1024  /* 10Kb shared memory*/

    class EneaBufferService : public BnEneaBuffer {
        public:
            static void instantiate();
            EneaBufferService();
            virtual ~EneaBufferService();
            virtual sp<IMemoryHeap> getBuffer();
        private:
            sp<MemoryHeapBase> mMemHeap;
    };

    sp<IMemoryHeap> EneaBufferService::getBuffer() {
        return mMemHeap;
    }

    void EneaBufferService::instantiate() {
        status_t status;
        LOGE("instantiate");
        status = defaultServiceManager()->addService(String16("vendor.enea.Buffer"), new EneaBufferService());
    }

    EneaBufferService::EneaBufferService() {
        LOGE("EneaBufferService construtor");
        //The memory is allocated using a MemoryHeapBase, and thereby is using ashmem
        mMemHeap = new MemoryHeapBase(MEMORY_SIZE);
        unsigned int *base = (unsigned int *) mMemHeap->getBase();
        *base=0xdeadcafe; //Initiate first value in buffer
    }

    EneaBufferService::~EneaBufferService() {
        mMemHeap = 0;
    }


    static sp<IMemoryHeap> receiverMemBase;

    unsigned int * getBufferMemPointer(void) {
        static sp<IEneaBuffer> eneaBuffer;

        /* Get the buffer service */
        if (eneaBuffer == NULL) {
            sp<IServiceManager> sm = defaultServiceManager();
            sp<IBinder> binder;
            binder = sm->getService(String16("vendor.enea.Buffer"));
            if (binder != 0) {
                LOGE("binder asInterface in getBufferMemPointer");
                eneaBuffer = IEneaBuffer::asInterface(binder);
            }
        }

        if (eneaBuffer == NULL) {
            LOGE("The buffer service is not published");
            return (unsigned int *)-1; /* return an errorcode... */
        } else {
            receiverMemBase = eneaBuffer->getBuffer();
            return (unsigned int *) receiverMemBase->getBase();
        }
    } 
}

using namespace android;

int main(int argc, char** argv) {
    unsigned int *base;

    EneaBufferService::instantiate();

    //Create binder threads for this "server"
    ProcessState::self()->startThreadPool();
    LOGD("Server is up and running");

    base = getBufferMemPointer(); 

    for(;;) {
        LOGD("EneaBufferServer base=%p Data=0x%x", base,*base);
        sleep(5);
    }
    // wait for threads to stop
    //   IPCThreadState::self()->joinThreadPool();
    return 0;
}
