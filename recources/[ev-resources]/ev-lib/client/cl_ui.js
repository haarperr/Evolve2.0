const registered = [];

function RegisterUICallback(name, cb) {
    AddEventHandler(`_aui_uiReq:${name}`, cb);

    if (GetResourceState('ev-ui') === 'started') exports['ev-ui'].RegisterUIEvent(name);

    registered.push(name);
}

function SendUIMessage(data) {
    exports['ev-ui'].SendUIMessage(data);
}

function SetUIFocus(hasFocus, hasCursor) {
    exports['ev-ui'].SetUIFocus(hasFocus, hasCursor);
}

function GetUIFocus() {
    return exports['ev-ui'].GetUIFocus();
}

AddEventHandler('_aui_uiReady', () => {
    registered.forEach((eventName) => exports['ev-ui'].RegisterUIEvent(eventName));
});