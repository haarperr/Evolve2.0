$(document).ready(function () {
    applyColorTheme()
    applyProgressBar()
    handlePlayPauseMusic()
    if (backgroundEffectNonReactiveLinesDots && !backgroundEffectReactiveLinesDots) particleground(document.getElementById('backgroundEffect'), {dotColor: 'rgba(255,255,255,0.35)',lineColor: 'rgba(255,255,255,0.35)'})

    if (backgroundEffectGeometryangle) {
        $('#backgroundEffect').Geometryangle({mesh:{}, lights: [{}], line: {}, vertex: {}})
        $("#videoBackground").remove()
    }

    if (backgroundEffectReactiveLinesDots && !backgroundEffectNonReactiveLinesDots) particlesJS("backgroundEffect",{"particles":{"number":{"value":100,"density":{"enable":true,"value_area":1000}},"color":{"value":"#ffffff"},"shape":{"type":"circle","stroke":{"width":0,"color":"#000000"},"polygon":{"nb_sides":5},"image":{"src":"img/github.svg","width":100,"height":100}},"opacity":{"value":0.5,"random":true,"anim":{"enable":true,"speed":1,"opacity_min":0.1,"sync":true}},"size":{"value":3,"random":true,"anim":{"enable":true,"speed":40,"size_min":0.1,"sync":true}},"line_linked":{"enable":true,"distance":150,"color":"#ffffff","opacity":0.4,"width":1},"move":{"enable":true,"speed":6,"direction":"none","random":true,"straight":false,"out_mode":"out","bounce":true,"attract":{"enable":true,"rotateX":600,"rotateY":1200}}},"interactivity":{"detect_on":"canvas","events":{"onhover":{"enable":true,"mode":"grab"},"onclick":{"enable":true,"mode":"push"},"resize":true},"modes":{"grab":{"distance":140,"line_linked":{"opacity":1}},"bubble":{"distance":400,"size":40,"duration":2,"opacity":8,"speed":3},"repulse":{"distance":200,"duration":0.4},"push":{"particles_nb":4},"remove":{"particles_nb":2}}},"retina_detect":true})

    if (backgroundEffectGradientOverlay && !backgroundEffectGeometryangle) {
        $("#backgroundEffect").addClass("gradientEffect")
        $(":root").css("--gradientEffectColors",backgroundEffectGradientOverlayColors.toString())
        $("#videoBackground").remove()
    }

    if (videoConfig["use-youtube-instead"]["active"]) $("#videoBackground").html('<iframe id="youtubePlayer" class="video" src="https://www.youtube.com/embed/'+videoConfig["use-youtube-instead"]["youtube-video-id"]+'?enablejsapi=1&autoplay=1&loop=1&playlist='+videoConfig["use-youtube-instead"]["youtube-video-id"]+'" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"></iframe>')

    if (!showLogo) $("#serverLogo").hide()
    if (rotatingLogo) $("#serverLogo").css("animation","rotatingLogo 10.0s infinite")

    if (!showServerName) $("#serverName").hide()
    $("#serverName").html(serverName)

    if (!showServerOnlinePlayerCount) $("#serverPlayerCount").hide()
    let xhr = new XMLHttpRequest();
    xhr.open('get', "https://servers-frontend.fivem.net/api/servers/single/"+serverCode);
    xhr.send();

    xhr.onload = function() {
        var response = JSON.parse(xhr.response)["Data"]
        $("#serverPlayerCount").html(response["clients"]+"/"+response["sv_maxclients"])
    };

    var textTipsHTML = ""
    textTips.forEach(element => {
        textTipsHTML = '<div class="slide">'+element+'</div>' + textTipsHTML
    })
    $("#textBox").html(textTipsHTML)

    if (!musicConfig["active"]) $("#musicPlayerDiv").remove()
    if (!videoConfig["active"]) $("#videoBackground").remove()

    document.body.addEventListener("mousemove", function(event){
        var cursor = document.getElementById("cursor");
        var x = event.pageX - cursor.width + 25;
        var y = event.pageY - 2;
        cursor.style.left = x+"px";
        cursor.style.top = y+"px";
    });

})

setTimeout(function() {
    $("#videoBackground").fadeIn(500)
}, 1000)

var currentProgress = 0

window.addEventListener('message', function(event) {
    var data = event.data
    if(data.eventName === 'loadProgress') {
        currentProgress = parseInt(data.loadFraction * 100)
    }
});

function loadingBar(){
    if (currentProgress >= 0 && currentProgress <= 20){
        $("#loadingBar1").removeClass("inactiveBar")
        $("#loadingBar1").addClass("activePulsatingBar")
    }
    if (currentProgress > 20 && currentProgress <= 40){
        $("#loadingBar1").removeClass("activePulsatingBar")
        $("#loadingBar1").addClass("activeBar")
        $("#loadingBar2").removeClass("inactiveBar")
        $("#loadingBar2").addClass("activePulsatingBar")
    }
    if (currentProgress > 40 && currentProgress <= 60){
        $("#loadingBar1").addClass("activeBar")
        $("#loadingBar1").removeClass("activePulsatingBar")
        $("#loadingBar2").addClass("activeBar")
        $("#loadingBar2").removeClass("activePulsatingBar")
        $("#loadingBar3").removeClass("inactiveBar")
        $("#loadingBar3").addClass("activePulsatingBar")
    }
    if (currentProgress > 60 && currentProgress <= 80){
        $("#loadingBar1").addClass("activeBar")
        $("#loadingBar1").removeClass("activePulsatingBar")
        $("#loadingBar2").addClass("activeBar")
        $("#loadingBar2").removeClass("activePulsatingBar")
        $("#loadingBar3").addClass("activeBar")
        $("#loadingBar3").removeClass("activePulsatingBar")
        $("#loadingBar4").removeClass("inactiveBar")
        $("#loadingBar4").addClass("activePulsatingBar")
    }
    if (currentProgress > 80 && currentProgress <= 100){        
        $("#loadingBar1").addClass("activeBar")
        $("#loadingBar1").removeClass("activePulsatingBar")
        $("#loadingBar2").addClass("activeBar")
        $("#loadingBar2").removeClass("activePulsatingBar")
        $("#loadingBar3").addClass("activeBar")
        $("#loadingBar3").removeClass("activePulsatingBar")
        $("#loadingBar4").addClass("activeBar")
        $("#loadingBar4").removeClass("activePulsatingBar")
        $("#loadingBar5").removeClass("inactiveBar")
        $("#loadingBar5").addClass("activePulsatingBar")
    }
    if (currentProgress >= 100){
        $("#loadingBar1").addClass("activeBar")
        $("#loadingBar1").removeClass("activePulsatingBar")
        $("#loadingBar2").addClass("activeBar")
        $("#loadingBar2").removeClass("activePulsatingBar")
        $("#loadingBar3").addClass("activeBar")
        $("#loadingBar3").removeClass("activePulsatingBar")
        $("#loadingBar4").addClass("activeBar")
        $("#loadingBar4").removeClass("activePulsatingBar")
        $("#loadingBar5").addClass("activeBar")
        $("#loadingBar5").removeClass("activePulsatingBar")
    }
    if (currentProgress+2.5 <= 100) {
        bar.style.width = currentProgress+2.5+"%"
    }
}

setInterval(loadingBar, 100)

$('.container .slides:gt(0)').hide()
function cycleThruTexts(){
    $('#textBox :first-child').fadeOut(1000)
    setTimeout(function () {
        $('#textBox :first-child').next('.slide').fadeIn(1000).end().appendTo('#textBox')
    },1500)
}

setTimeout(cycleThruTexts(),1000)

setInterval(function(){
      cycleThruTexts()
}, 12500)

function setVolume(id, value) {
    var audio = document.getElementById(id)
    audio.volume = value / 100
}

var loaded = false

function handlePlayPauseMusic(){
    if (!loaded && !musicConfig["should-music-autoplay"]) {
        document.getElementById('musicPlayer').pause()
        loaded = true
        return
    }
    if (document.getElementById('musicPlayer').paused) {
        document.getElementById('musicPlayer').play()
        $("#musicPlayerButton").html('<i class="fa-solid fa-circle-pause"></i>')
    } 
    else {
        document.getElementById('musicPlayer').pause()
        $("#musicPlayerButton").html('<i class="fa-solid fa-circle-play"></i>')
    }
}

function applyColorTheme() {
    $(":root").css("--backgroundOverlayColor",colorThemes[currentTheme]["background-overlay-color"])
    $(":root").css("--backgroundOverlayRadialSecondColor",colorThemes[currentTheme]["background-overlay-radial-second-color"])
    $(":root").css("--normalColors",colorThemes[currentTheme]["normal-colors"])
    $(":root").css("--accentColors",colorThemes[currentTheme]["accent-colors"])

    $(":root").css("--loadingBarPulsatingColorsOn1",colorThemes[currentTheme]["loading-bar-colors"]["pulsating-colors"]["on"]["color-1"])
    $(":root").css("--loadingBarPulsatingColorsOn2",colorThemes[currentTheme]["loading-bar-colors"]["pulsating-colors"]["on"]["color-2"])
    $(":root").css("--loadingBarPulsatingColorsOn3",colorThemes[currentTheme]["loading-bar-colors"]["pulsating-colors"]["on"]["color-3"])
    $(":root").css("--loadingBarPulsatingColorsOff1",colorThemes[currentTheme]["loading-bar-colors"]["pulsating-colors"]["off"]["color-1"])
    $(":root").css("--loadingBarPulsatingColorsOff2",colorThemes[currentTheme]["loading-bar-colors"]["pulsating-colors"]["off"]["color-2"])
    $(":root").css("--loadingBarPulsatingColorsOff3",colorThemes[currentTheme]["loading-bar-colors"]["pulsating-colors"]["off"]["color-3"])
    $(":root").css("--loadingBarActiveColors1",colorThemes[currentTheme]["loading-bar-colors"]["active-colors"]["color-1"])
    $(":root").css("--loadingBarActiveColors2",colorThemes[currentTheme]["loading-bar-colors"]["active-colors"]["color-2"])
    $(":root").css("--loadingBarActiveColors3",colorThemes[currentTheme]["loading-bar-colors"]["active-colors"]["color-3"])
    $(":root").css("--loadingBarInactiveColors1",colorThemes[currentTheme]["loading-bar-colors"]["inactive-colors"]["color-1"])
    $(":root").css("--loadingBarInactiveColors2",colorThemes[currentTheme]["loading-bar-colors"]["inactive-colors"]["color-2"])
    
    if (colorThemes[currentTheme]["background-overlay-radial"]) {
        $("#main").css("background","radial-gradient(circle, var(--backgroundOverlayRadialSecondColor) 35%, var(--backgroundOverlayColor) 100%)")
    }
    if (reflectiveTextTips) {
        $("#textBox").css("-webkit-box-reflect","below 0.35vw linear-gradient(to bottom, transparent, rgba(0,0,0,0.1) 50%)")
    }

    if (reflectiveLoadingText) {
        $("span").css("-webkit-box-reflect","below 0.1vw linear-gradient(to bottom, transparent, rgba(0,0,0,0.1) 50%)")
    }
}

function applyProgressBar() {
    if (progressBarConfig["segmented-progress-bar"]) {
        $("#normalBar").hide()
        $("#segmentedBar").show()
    }
    if (progressBarConfig["normal-progress-bar"]) {
        $("#segmentedBar").hide()
        $("#normalBar").show()
    }
}

var scriptElement = document.createElement('script')
scriptElement.src = "https://www.youtube.com/iframe_api"
var scriptTag = document.getElementsByTagName('script')[0]
scriptTag.parentNode.insertBefore(scriptElement, scriptTag)
var youtubePlayer
function onYouTubeIframeAPIReady() {
    youtubePlayer = new YT.Player("youtubePlayer",{events:{'onReady':onPlayerReady}})
}
function onPlayerReady() {
    youtubePlayer.mute()
    youtubePlayer.playVideo()
}