/*
 * EneaBufferClient.cpp
 *  Created on: 19 mars 2010  Author: Zingo Andersen
 *  License: Public Domain (steal and use what you like)
 *
 *  Get the shared memory buffer from the server and change the first int value
 *  by adding one to it. The Server should be running in parallell pleas view
 *  the logcat for the result
 */


#include "IEneaBuffer.h"
#include <binder/MemoryHeapBase.h>
#include <binder/IServiceManager.h>

namespace android {
    static sp<IMemoryHeap> receiverMemBase;

    unsigned int * getBufferMemPointer(void)
    {
        static sp<IEneaBuffer> eneaBuffer = 0;

        /* Get the buffer service */
        if (eneaBuffer == NULL)
        {
            sp<IServiceManager> sm = defaultServiceManager();
            sp<IBinder> binder;
            LOGE("EneaBufferClient get service");
            binder = sm->getService(String16("vendor.enea.Buffer"));
            if (binder != 0)
            {
                eneaBuffer = IEneaBuffer::asInterface(binder);
            }
        }
        if (eneaBuffer == NULL)
        {
            LOGE("The EneaBufferServer is not published");
            return (unsigned int *)-1; /* return an errorcode... */
        }
        else
        {
            receiverMemBase = eneaBuffer->getBuffer();
            return (unsigned int *) receiverMemBase->getBase();
        }
    }

}

using namespace android;

int main(int argc, char** argv)
{
 // base could be on same address as Servers base but this
 // is purely by luck do NEVER rely on this. Linux memory
 // management may put it wherever it likes.
    unsigned int *base = getBufferMemPointer();
    if(base != (unsigned int *)-1)
    {
        LOGE("EneaBufferClient base=%p Data=0x%x\n",base, *base);
        *base = (*base)+1;
        LOGE("EneaBufferClient base=%p Data=0x%x CHANGED\n",base, *base);
        receiverMemBase = 0;
    }
    else
    {
     LOGE("Error shared memory not available\n");
    }
    return 0;
}
