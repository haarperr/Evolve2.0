function btnHangUp(){
    $.post('https://ev-phone/btnHangup', JSON.stringify({}))
} 

function btnAnswer(){ 
    $.post('https://ev-phone/btnAnswer', JSON.stringify({}))
}

function pingReject(){
    $.post('https://ev-phone/ev-ui:pingReject', JSON.stringify({}))
} 

function pingAccept(){
    $.post('https://ev-phone/ev-ui:pingAccept', JSON.stringify({}))
}

function billDecline(){
}

function billAccept(data){
    let price = data.amount
    let sID = data.sellerID
    $.post('https://ev-phone/purchaseCar', JSON.stringify({amount:price, sID: sID}))
}

function createCameraDropdown(cameraData) {
    var camData = `<li><a href="#" class="waves-effect waves-light" onclick="SetStateBagCamera('${cameraData.cid}')">${cameraData.name}</a></li>`
    console.log(camData)
    $('.removeCamera').append(camData);
}


function SetStateBagCamera(func) {
    $("#cameraRemoveID").val(func)
}