/*
 * IEneaBuffer.cpp
 *  Created on: 19 mars 2010  Author: Zingo Andersen
 *  License: Public Domain (steal and use what you like)
 *
 * Buffer classes to handle the binder communication
 */
#define LOG_NDEBUG 0
#define LOG_TAG "IEneaBuffer"
#include <utils/Log.h>
#include <stdint.h>
#include <sys/types.h>
#include <binder/MemoryHeapBase.h>
#include <IEneaBuffer.h>

namespace android {

    enum {
        GET_BUFFER = IBinder::FIRST_CALL_TRANSACTION
    };

    /* --- Client side --- */
    class BpEneaBuffer: public BpInterface<IEneaBuffer> {
        public:
            BpEneaBuffer(const sp<IBinder>& impl) : BpInterface<IEneaBuffer>(impl) {
                LOGE("BpEneaBuffer constructor");

        }

            sp<IMemoryHeap> getBuffer() {
                Parcel data, reply;
                sp<IMemoryHeap> memHeap = NULL;
                data.writeInterfaceToken(IEneaBuffer::getInterfaceDescriptor());
                // This will result in a call to the onTransact()
                // method on the server in it's context (from it's binder threads)
                remote()->transact(GET_BUFFER, data, &reply);
                memHeap = interface_cast<IMemoryHeap> (reply.readStrongBinder());
                return memHeap;
            }
    };

    IMPLEMENT_META_INTERFACE(EneaBuffer, "android.vendor.IEneaBuffer");

    /* --- Server side --- */

    status_t BnEneaBuffer::onTransact(uint32_t code, const Parcel& data, Parcel* reply, uint32_t flags)
    {
        switch (code)
        {
            case GET_BUFFER:
                {
                    CHECK_INTERFACE(IEneaBuffer, data, reply);
                    sp<IMemoryHeap> Data = getBuffer();
                    if (Data != NULL)
                    {
                        reply->writeStrongBinder(Data->asBinder());
                    }
                    return NO_ERROR;
                    break;
                }
            default:
                return BBinder::onTransact(code, data, reply, flags);
        }
    }

}; // namespace android
