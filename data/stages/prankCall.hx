import flixel.math.FlxBasePoint;

public var redarCam:FlxCamera;
public var zorkaCam:FlxCamera;

var dadCamOffset = FlxPoint.get(-10105, -10725);
var dadCamLerpOffset = FlxPoint.get(-10105, -10725);
var bfCamOffset = FlxPoint.get(9800, 8964);
var bfCamLerpOffset = FlxPoint.get(9800, 8964);

var movement = new FlxBasePoint();

function create() {
	redarCam = new FlxCamera(0,0, FlxG.width/2, FlxG.height);
	redarCam.bgColor = FlxColor.BLACK;

	zorkaCam = new FlxCamera(FlxG.width/2,0, FlxG.width/2, FlxG.height);
	zorkaCam.bgColor = FlxColor.BLACK;

    FlxG.cameras.insert(redarCam, 1, false);
	FlxG.cameras.insert(zorkaCam, 2, false);

    for (zorkaObj in [boyfriend, stage.stageSprites['sky'], stage.stageSprites['awayBg'], stage.stageSprites['backHouse'], stage.stageSprites['stret'], stage.stageSprites['lopata']]){
        zorkaObj.cameras = [zorkaCam];
    }

    for (redarObj in [dad, stage.stageSprites['wall'], stage.stageSprites['stand'], stage.stageSprites['store']]){
        redarObj.cameras = [redarCam];
    }

    stage.stageSprites['line'].cameras = [camHUD];
    stage.stageSprites['line'].x = FlxG.width / 2 - stage.stageSprites['line'].width / 2;
    stage.stageSprites['line'].y = FlxG.height / 2 - stage.stageSprites['line'].height / 2;

    zorkaCam.zoom = 0.775;
	redarCam.zoom = 0.7;

    zorkaCam.focusOn(bfCamLerpOffset);
    redarCam.focusOn(dadCamLerpOffset);
}

function update(elapsed){
    for (a in comboGroup.members)
        a.camera = camHUD;

    dadCamOffset.x = lerp(dadCamOffset.x, -10105, 0.1);
    dadCamOffset.y = lerp(dadCamOffset.y, -10725, 0.1);

    dadCamLerpOffset.x = lerp(dadCamLerpOffset.x, dadCamOffset.x, 0.3);
    dadCamLerpOffset.y = lerp(dadCamLerpOffset.y, dadCamOffset.y, 0.3);

    bfCamOffset.x = lerp(bfCamOffset.x, 9800, 0.1);
    bfCamOffset.y = lerp(bfCamOffset.y, 8964, 0.1);

    bfCamLerpOffset.x = lerp(bfCamLerpOffset.x, bfCamOffset.x, 0.3);
    bfCamLerpOffset.y = lerp(bfCamLerpOffset.y, bfCamOffset.y, 0.3);

    zorkaCam.focusOn(bfCamLerpOffset);
    redarCam.focusOn(dadCamLerpOffset);

    switch(dad.animation.name){
        case "singLEFT": dadCamOffset.x -= 1;
        case "singDOWN": dadCamOffset.y += 1;
        case "singUP": dadCamOffset.y -= 1;
        case "singRIGHT": dadCamOffset.x += 1;

    }

    switch(boyfriend.animation.name){
        case "singLEFT": bfCamOffset.x -= 1;
        case "singDOWN": bfCamOffset.y += 1;
        case "singUP": bfCamOffset.y -= 1;
        case "singRIGHT": bfCamOffset.x += 1;
    }
}