%prologues := 3;
outputtemplate := "%j.ps";
%outputformat := "ps";

input metauml

beginfig(1);
Class.IInterface("IInterface")()("+asBinder(): sp<IBinder>",
        "+asBinder() const:sp<const IBinder>",
        "#virtual ~IInterface()",
        "#onAsBinder() = 0: virtual IBinder*");
Class.BnInterface("BnInterface")()(
        "+queryLocalInterface(const String16&): virtual sp<IInterface>",
        "+getInterfaceDescriptor() const : virtual const String16&",
        "#onAsBinder: virtual IBinder*");
Class.BpInterface("BpInterface")()(
        "#onAsBinder: virtual IBinder*");
Class.IEneaBuffer("IEneaBuffer")("+descriptor")(
        "+asInterface: sp<IEneaBuffer>",
        "+getInterfaceDescriptor",
        "+getBuffer() = 0:virtual sp<IMemoryHeap>");
Class.BnEneaBuffer("BnEneaBuffer")()("+onTransact");
Class.BpEneaBuffer("BpEneaBuffer")()("+getBuffer");
Class.EneaBufferService("EneaBufferService")()("instantiate",
        "getBuffer");

topToBottom(30)(IInterface, IEneaBuffer);
IEneaBuffer.se = BnInterface.nw + (70, 20);
leftToRight(30)(BpInterface, BnInterface);
topToBottom(30)(BpInterface, BpEneaBuffer);
topToBottom(30)(BnInterface, BnEneaBuffer);
%leftToRight(50)(BpEneaBuffer, BnEneaBuffer);
topToBottom(30)(BnEneaBuffer, EneaBufferService);

drawObjects(IInterface, IEneaBuffer, BnInterface, BpInterface, 
        BnEneaBuffer, BpEneaBuffer, EneaBufferService);

stepY := 7;

link(inheritance)(IEneaBuffer.n -- IInterface.s);
link(inheritance)(BpEneaBuffer.n -- BpInterface.s);
link(inheritance)(pathStepY(BpEneaBuffer.n, IEneaBuffer.s, stepY));
link(inheritance)(BnEneaBuffer.n -- BnInterface.s);
link(inheritance)(pathStepY(BnEneaBuffer.n, IEneaBuffer.s, stepY));
link(inheritance)(EneaBufferService.n -- BnEneaBuffer.s);
endfig;

           end
