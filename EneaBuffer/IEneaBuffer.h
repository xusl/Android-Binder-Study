/*
 * IEneabuffer.h
 *  Created on: 19 mars 2010  Author: Zingo Andersen
 *  License: Public Domain (steal and use what you like)
 *
 * Buffer classes to handle the binder communication  */

#ifndef IENEABUFFER_H_
#define IENEABUFFER_H_

#include <utils/RefBase.h>
#include <binder/IInterface.h>
#include <binder/Parcel.h>
#include <binder/IMemory.h>
#include <utils/Timers.h>

namespace android {
    class IEneaBuffer: public IInterface
    {
        public:
            DECLARE_META_INTERFACE(EneaBuffer);
            virtual sp<IMemoryHeap>  getBuffer() = 0;
    };

    /* --- Server side --- */ 
    class BnEneaBuffer: public BnInterface<IEneaBuffer>
    {
        public:
            virtual status_t    onTransact( uint32_t code,
                    const Parcel& data,
                    Parcel* reply,
                    uint32_t flags = 0);
    };

}; // namespace android 
#endif /* IENEABUFFER_H_ */
