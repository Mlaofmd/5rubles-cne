import hxvlc.flixel.FlxVideoSprite;
import funkin.backend.system.framerate.Framerate;

var camFPS:HudCamera;
var camVideo:FlxCamera;

public var fpsfunniCounter:FlxText;
var finalFPS:Float = 0;

var introVid:FlxVideoSprite = new FlxVideoSprite();

introLength = 0;

function create(){
    camFPS = new HudCamera();
    FlxG.cameras.add(camFPS, false);
    camFPS.bgColor = 0;
    fpsfunniCounter = new FlxText(10, 3, 400, 24);
    fpsfunniCounter.setFormat("arial.ttf", 12, 0xFFFFFF);
    fpsfunniCounter.antialiasing = true;
    fpsfunniCounter.scrollFactor.set();
    fpsfunniCounter.cameras = [camFPS];
    add(fpsfunniCounter);
    finalFPS = 0;

    Framerate.instance.visible = false;


    camVideo = new FlxCamera();
    camVideo.bgColor = 0x00000000;
    FlxG.cameras.insert(camVideo, 1, false);
    
    add(introVid).load(Paths.video("uc intro"), [":no-audio"]);

    introVid.bitmap.onFormatSetup.add(function():Void
    {
        if (introVid.bitmap != null && introVid.bitmap.bitmapData != null)
        {
            final scale:Float = Math.min(FlxG.width / introVid.bitmap.bitmapData.width, FlxG.height / introVid.bitmap.bitmapData.height);

            introVid.setGraphicSize(introVid.bitmap.bitmapData.width * scale, introVid.bitmap.bitmapData.height * scale);
            introVid.updateHitbox();
            introVid.screenCenter();
        }
    });

    introVid.scrollFactor.set();
    introVid.camera = camVideo;

    camGame.visible = camHUD.visible = false;

    introVid.play();

    for (char in [1, 2]){
        strumLines.members[0].characters[char].visible = false;
    }
}

function postCreate(){
    strumLines.members[3].camera = camGame; 

    for (strumNote in strumLines.members[3].members){
        strumNote.scrollFactor.set(1,1);
        strumNote.x -= 0; // позиции сама выставишь
        strumNote.y -= 0;
        strumNote.alpha = 0.5;
    }
}

function update(elapsed){
    camVideo.zoom = camHUD.zoom;

    finalFPS = CoolUtil.fpsLerp(finalFPS, FlxG.elapsed == 0 ? 0 : (1 / FlxG.elapsed), 0.25);
    fpsfunniCounter.text = "FPS: " + Std.string(Math.floor(finalFPS));
}

function stepHit(_){
    switch(_){
        case 304:
            introVid.visible = false;
            camGame.visible = camHUD.visible = true;
        case 816:
            camFPS.visible = false;
            Framerate.instance.visible = true;
            createRubleHud();
            isHudActivated = true;
            dad.visible = false;
            strumLines.members[0].characters[1].visible = true;
            iconP2.setIcon('rubl4evil');
            iconP1.setIcon('naisonji');
    }
}

// это чтобы в паузе меню не было конфликтов

function onSubstateOpen() if (introVid.exists && paused) introVid.pause();
function onSubstateClose() if (introVid.exists && paused) introVid.resume();
function onFocus() onSubstateOpen(); // lil fix for when the window regains focus