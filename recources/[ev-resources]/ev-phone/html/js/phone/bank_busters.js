function createBankBustersDev() {
    var dataType = "Active"
    var html = `<div bbHover=1 class="component-paper bb-count" style="width: 100%;">
        <div class="main-container">`
            if (dataType !== "Expired" || dataType !== "Claimed") {
            html +=    `<div class="details ">
            <div class="title ">
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary">
                Fleeca Hawick</p>
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word; padding:0px;">5h 31m</p>
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word; text-align:right; margin-top:-8%">Active</p>
                </div>
            </div>
                <div bbHover=1 class="actions actions-show">
                    <div data-tippy-content="Claim" class="claim-bb" bbid=1>
                        <svg style="font-size: 2.3vh;" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="eye" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" class="svg-inline--fa fa-eye fa-w-18 fa-1x"><path fill="currentColor" d="M559.7 392.2c17.8-13.1 21.6-38.1 8.5-55.9s-38.1-21.6-55.9-8.5L392.6 416H272c-8.8 0-16-7.2-16-16s7.2-16 16-16h16 64c17.7 0 32-14.3 32-32s-14.3-32-32-32H288 272 193.7c-29.1 0-57.3 9.9-80 28L68.8 384H32c-17.7 0-32 14.3-32 32v64c0 17.7 14.3 32 32 32H192 352.5c29 0 57.3-9.3 80.7-26.5l126.6-93.3zm-367-8.2c.3 0 .6 0 .9 0c0 0 0 0 0 0c-.3 0-.6 0-.9 0z" class=""></path></svg>
                    </div>
                </div>`
            } else {
                html += `<div class="details ">
                <div class="title ">
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word;">Fleeca Hawick</p>
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word; text-align:right;">${dataType}</p>
                </div>
            </div>`
            }
        html += `</div>
    </div>`
    $('#bankbusters-containment').append(html);
    tippy('[data-tippy-content]', {
        theme: 'nopixel',
        animation: 'scale',
        inertia: true,
    })
    $(".eye-camera").click(function () {
        var bbid = $(this).attr('bbid');
        $.post('https://ev-phone/tryClaimBank', JSON.stringify({
            bbid: bbid
        }));
    })
    $(".component-paper").mouseover(function () {
        overid = $(this).attr("bbHover")
        $(".actions[bbHover=" + overid + "]").css("display", "flex");
    }).mouseout(function () {
        $(".actions").css("display", "none")
    })
};

//<div bankBustersHover="${random}" class="actions actions-show">
//<div data-tippy-content="View" class="eye-bankbusters" bankBustersID="6969">
//    <svg style="font-size: 2.3vh;" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="eye" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" class="svg-inline--fa fa-eye fa-w-18 fa-1x"><path fill="currentColor" d="M572.52 241.4C518.29 135.59 410.93 64 288 64S57.68 135.64 3.48 241.41a32.35 32.35 0 0 0 0 29.19C57.71 376.41 165.07 448 288 448s230.32-71.64 284.52-177.41a32.35 32.35 0 0 0 0-29.19zM288 400a144 144 0 1 1 144-144 143.93 143.93 0 0 1-144 144zm0-240a95.31 95.31 0 0 0-25.31 3.79 47.85 47.85 0 0 1-66.9 66.9A95.78 95.78 0 1 0 288 160z" class=""></path></svg>
//</div>
//</div>

function createBankBustersGroup(bankBusters) {
    $(".bankBustersGroupLeader-entries").empty();
    $.each(bankBusters, function (__, group) {
        var html = ``;
        var random = Math.floor(Math.random() * 100000) + 1;
        if (group.leader === true) {
            html += `<div bankBustersHover=${random} class="component-paper bankbusters-count" style="width: 100%;">
            <div class="main-container">
                <div class="image">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="user-graduate" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="svg-inline--fa fa-user-graduate fa-w-16 fa-3x"><path fill="currentColor" d="M219.3 .5c3.1-.6 6.3-.6 9.4 0l200 40C439.9 42.7 448 52.6 448 64s-8.1 21.3-19.3 23.5L352 102.9V160c0 70.7-57.3 128-128 128s-128-57.3-128-128V102.9L48 93.3v65.1l15.7 78.4c.9 4.7-.3 9.6-3.3 13.3s-7.6 5.9-12.4 5.9H16c-4.8 0-9.3-2.1-12.4-5.9s-4.3-8.6-3.3-13.3L16 158.4V86.6C6.5 83.3 0 74.3 0 64C0 52.6 8.1 42.7 19.3 40.5l200-40zM129.1 323.2l83.2 88.4c6.3 6.7 17 6.7 23.3 0l83.2-88.4c73.7 14.9 129.1 80 129.1 158.1c0 17-13.8 30.7-30.7 30.7H30.7C13.8 512 0 498.2 0 481.3c0-78.1 55.5-143.2 129.1-158.1z" class=""></path></svg>
                </div>
                <div class="details ">
                    <div class="title ">
                    <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                        style="word-break: break-word;">${group.name}</p>
                    </div>
                </div>
            </div>
        </div>`
        } else if (group.leader === false) {
            html += `<div bankBustersHover=${random} class="component-paper bankbusters-count" style="width: 100%;">
            <div class="main-container">
                <div class="image">
                    <svg aria-hidden="true" focusable="false" data-prefix="fas" data-icon="user" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="svg-inline--fa fa-user fa-w-16 fa-3x"><path fill="currentColor" d="M224 256c70.7 0 128-57.3 128-128S294.7 0 224 0S96 57.3 96 128s57.3 128 128 128zm-45.7 48C79.8 304 0 383.8 0 482.3C0 498.7 13.3 512 29.7 512H418.3c16.4 0 29.7-13.3 29.7-29.7C448 383.8 368.2 304 269.7 304H178.3z" class=""></path></svg>
                </div>
                <div class="details ">
                    <div class="title ">
                    <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                        style="word-break: break-word;">${group.name}</p>
                    </div>
                </div>
                <div bankBustersHover="${random}" class="actions actions-show">
                    <div data-tippy-content="Kick" class="kick-bankbusters" bankBustersID="6969">
                        <svg style="font-size: 2.3vh;" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="user-slash" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512" class="svg-inline--fa fa-user-slash fa-w-18 fa-1x"><path fill="currentColor"  d="M38.8 5.1C28.4-3.1 13.3-1.2 5.1 9.2S-1.2 34.7 9.2 42.9l592 464c10.4 8.2 25.5 6.3 33.7-4.1s6.3-25.5-4.1-33.7L353.3 251.6C407.9 237 448 187.2 448 128C448 57.3 390.7 0 320 0C250.2 0 193.5 55.8 192 125.2L38.8 5.1zM264.3 304.3C170.5 309.4 96 387.2 96 482.3c0 16.4 13.3 29.7 29.7 29.7H514.3c3.9 0 7.6-.7 11-2.1l-261-205.6z" class=""></path></svg>
                    </div>
                    <div data-tippy-content="Promote to Leader" class="promote-to-leader-bankbusters" bankBustersID="6969">
                        <svg style="font-size: 2.3vh;" aria-hidden="true" focusable="false" data-prefix="far" data-icon="user-graduate" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512" class="svg-inline--fa fa-user-graduate fa-w-18 fa-1x"><path fill="currentColor" d="M219.3 .5c3.1-.6 6.3-.6 9.4 0l200 40C439.9 42.7 448 52.6 448 64s-8.1 21.3-19.3 23.5L352 102.9V160c0 70.7-57.3 128-128 128s-128-57.3-128-128V102.9L48 93.3v65.1l15.7 78.4c.9 4.7-.3 9.6-3.3 13.3s-7.6 5.9-12.4 5.9H16c-4.8 0-9.3-2.1-12.4-5.9s-4.3-8.6-3.3-13.3L16 158.4V86.6C6.5 83.3 0 74.3 0 64C0 52.6 8.1 42.7 19.3 40.5l200-40zM129.1 323.2l83.2 88.4c6.3 6.7 17 6.7 23.3 0l83.2-88.4c73.7 14.9 129.1 80 129.1 158.1c0 17-13.8 30.7-30.7 30.7H30.7C13.8 512 0 498.2 0 481.3c0-78.1 55.5-143.2 129.1-158.1z"class=""></path></svg>
                    </div>
                </div>
            </div>
        </div>`
        }
        $(".bankBustersGroupLeader-entries").prepend(html)
    })
    tippy('[data-tippy-content]', {
        theme: 'nopixel',
        animation: 'scale',
        inertia: true,
      })
    $(".component-paper").mouseover(function () {
        overid = $(this).attr("bankBustersHover")
        $(".actions[bankBustersHover=" + overid + "]").css("display", "flex");
    }).mouseout(function () {
        $(".actions").css("display", "none");
    });
}

function createBankBusters(data) {
    var dataType = data.status
    console.log(data.status)
    var html = `<div bbHover=${data.bankID} class="component-paper bb-count" style="width: 100%;">
        <div class="main-container">`
            if (dataType !== "Expired" || dataType !== "Claimed") {
            html += `<div class="details ">
            <div class="title ">
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary">
                    Fleeca Hawick</p>
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word; padding:0px;">${data.bankExpires}</p>
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word; text-align:right; margin-top:-8%">${dataType}</p>
                </div>
            </div>
                <div bbHover=${data.bankID} class="actions actions-show">
                    <div data-tippy-content="Claim" class="claim-bb" bbid=${data.bankID}>
                        <svg style="font-size: 2.3vh;" aria-hidden="true" focusable="false" data-prefix="fas" data-icon="eye" role="img" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512" class="svg-inline--fa fa-eye fa-w-18 fa-1x"><path fill="currentColor" d="M559.7 392.2c17.8-13.1 21.6-38.1 8.5-55.9s-38.1-21.6-55.9-8.5L392.6 416H272c-8.8 0-16-7.2-16-16s7.2-16 16-16h16 64c17.7 0 32-14.3 32-32s-14.3-32-32-32H288 272 193.7c-29.1 0-57.3 9.9-80 28L68.8 384H32c-17.7 0-32 14.3-32 32v64c0 17.7 14.3 32 32 32H192 352.5c29 0 57.3-9.3 80.7-26.5l126.6-93.3zm-367-8.2c.3 0 .6 0 .9 0c0 0 0 0 0 0c-.3 0-.6 0-.9 0z" class=""></path></svg>
                    </div>
                </div>`
            } else {
                html += `<div class="details ">
                <div class="title ">
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word;">${data.bankName}</p>
                <p class="MuiTypography-root MuiTypography-body2 MuiTypography-colorTextPrimary"
                    style="word-break: break-word; text-align:right;">${dataType}</p>
                </div>
            </div>`
            }
        html += `</div>
    </div>`
    $('#bankbusters-containment').append(html);
    tippy('[data-tippy-content]', {
        theme: 'nopixel',
        animation: 'scale',
        inertia: true,
    })
    $(".eye-camera").click(function () {
        var bbid = $(this).attr('bbid');
        $.post('https://ev-phone/tryClaimBank', JSON.stringify({
            bbid: bbid
        }));
    })
    $(".component-paper").mouseover(function () {
        overid = $(this).attr("bbHover")
        $(".actions[bbHover=" + overid + "]").css("display", "flex");
    }).mouseout(function () {
        $(".actions").css("display", "none")
    })
};

$(document).ready(function() {
    $("#bankbusters-grouping").fadeOut()
    $("#leaveBankBusterGroup").hide();
})

$("#createBankBusterGroup").on('click', function() {
    $.post('https://ev-phone/createBankbusterGroup', JSON.stringify({}))
    refreshBankBusters()
})

$("#leaveBankBusterGroup").on('click', function() {
    var insertedCid = $("#bankbustercid").val();
    var insertedGroupID = $("#bankbustergroupid").val();
    $("#bankbusters-grouping").fadeOut();
    $("#leaveBankBusterGroup").hide();
    $("#createBankBusterGroup").show();
    $.post('https://ev-phone/leaveBankbusterGroup', JSON.stringify({
        cid: insertedCid,
        groupID: insertedGroupID
    }))
})

$("#invite-bankbusters").on('click', function() {
    $(".bankbusters-add-cid").css('display','flex');
})

$("#bankbuster-close-cid").on('click', function() {
    $(".bankbusters-add-cid").fadeOut()
})

$("#bankbuster-submit-cid").on('click', function() {
    var insertedCid = $("#bankbustercid").val();
    var insertedGroupID = $("#bankbustergroupid").val();
    $(".bankbusters-add-cid").fadeOut();
    complateInputQuick()
    setTimeout(() => {
        $.post('https://ev-phone/addBankbusterGroup', JSON.stringify({
            cid: insertedCid,
            groupID: insertedGroupID
        }));
        $("#bankbustercid").val("");
        refreshBankBusters()
    }, 1500)
})

function refreshBankBusters() {
    $('#bankbusters-containment').empty();
    openContainer("bankbusters")
    $.post('https://ev-phone/getCurrentBanks', JSON.stringify({}))
    setTimeout(() => {
        $.post('https://ev-phone/inBankBusterGroup', JSON.stringify({}))
    }, 1500)
}
