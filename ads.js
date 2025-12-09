function noAdGoToScene() {
    // 直接从全局访问 GameConfig，避免使用 __require
    var settings = window._CCSettings || {};
    var launchScene = settings.launchScene || "db://assets/Scene/MainGameScene.fire";

    console.log("noAdGoToScene: Loading scene", launchScene);

    cc.director.loadScene(launchScene, null,
        function() {
            adCompleteFlag = false;

            // show canvas
            var canvas = document.getElementById('GameCanvas');
            if (canvas) {
                canvas.style.visibility = '';
            }
            var div = document.getElementById('GameDiv');
            if (div) {
                div.style.backgroundImage = '';
            }

            cc.loader.onProgress = null;
            console.log('Success to load scene: ' + launchScene);
        }
    );
}

// 空的 showMyAds 函数，防止错误
function showMyAds() {
    console.log("showMyAds called (ads disabled)");
    // 不显示广告
}
