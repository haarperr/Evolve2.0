const regged = [];

function RegisterInterfaceCallback(name, cb) {
    AddEventHandler(`_apx_uiReq:${name}`, cb);

    if (GetResourceState('ev-interface') === 'started') exports['ev-interface'].RegisterIntefaceEvent(name);

    regged.push(name);
}

function SendInterfaceMessage(data) {
    exports['ev-interface'].SendInterfaceMessage(data);
}

function SetInterfaceFocus(hasFocus, hasCursor) {
    exports['ev-interface'].SetInterfaceFocus(hasFocus, hasCursor);
}

function GetInterfaceFocus() {
    return exports['ev-interface'].GetInterfaceFocus();
}

AddEventHandler('_apx_uiReady', () => {
    regged.forEach((eventName) => exports['ev-interface'].RegisterIntefaceEvent(eventName));
});