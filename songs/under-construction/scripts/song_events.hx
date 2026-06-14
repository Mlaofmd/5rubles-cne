import openfl.geom.ColorTransform;
import hxvlc.flixel.FlxVideoSprite;
import funkin.backend.system.framerate.Framerate;
import flixel.FlxObject;
import openfl.display.BlendMode;

var camFPS:HudCamera;
var camVideo:FlxCamera;

public var fpsfunniCounter:FlxText;
var finalFPS:Float = 0;

var introVid:FlxVideoSprite = new FlxVideoSprite();

introLength = 0;

function getRandomFactor():Float
	return FlxG.random.float(0.9, 1.1);

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

    var tumanBG = new TumanEmitter('stages/under_construction/phase1/fog', 1, -1000, 3200, -380, 380, 1, 0.15, 2.6, 4.8);
	tumanBG.scrollFactor.set(0.76, 0.95);
	tumanBG.velocity.set(40, 120);
    insert(members.indexOf(stage.stageSprites["bg"]),tumanBG);

    var tumanFG = new TumanEmitter('stages/under_construction/phase1/fog', 1, -1000, 3200, 480, 1420, 1.35, 0.075, 1.6, 3);
	tumanFG.scrollFactor.set(1.4, 1.15);
	tumanFG.velocity.set(110, 250);
    add(tumanFG);

    var mult = Options.lowMemoryMode ? 4 : 1;
	var tx = FlxG.random.float(1000, 1200);
	for (_ in 0...Std.int(FlxG.random.int(9, 11) / mult))
	{
		tumanBG.spawnTuman().x += tx * getRandomFactor();
		tx += FlxG.random.float(200, 500) * mult;
	}
    tx = FlxG.random.float(1000, 1200);
	for (_ in 0...Std.int(FlxG.random.int(10, 13) / mult))
	{
		tumanFG.spawnTuman().x += tx * getRandomFactor();
		tx += FlxG.random.float(200, 500) * mult;
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


// TODO: немного переписать чтобы не было так говяно
class TumanEmitter extends FlxObject
{
	static final JUMP_CHANCE = 1 / 4096 * 100; // шайни покемон шанс лол, удачи братан

	var group:FlxGroup;
	var scale:Float;
	var alpha:Float;

	var minTime:Float;
	var maxTime:Float;
	var timer = 0;
	var spawnTime:Float;
	var lastY:Float;

	var texture:String;
	var maxIndex:Int;

	var shader:FlxShader;
	var colorTransform:ColorTransform;

	public function new(texture:String, maxIndex:Int, startX:Float, endX:Float, startY:Float, endY:Float, scale:Float, alpha:Float, minTime:Float, maxTime:Float)
	{
		super(startX, startY, endX - startX, endY - startY);
		group = new FlxGroup();
		this.texture = texture;
		this.maxIndex = maxIndex;
		this.scale = scale;
		var mult = Options.lowMemoryMode ? 4 : 1;
		this.minTime = minTime * mult;
		this.maxTime = maxTime * mult;
		spawnTime = getSpawnTime();
		this.alpha = alpha;
		colorTransform = new ColorTransform();
	}

	var goofyTweensOfGoofySprites:Map<FlxSprite, FlxTween> = [];
	public function spawnTuman():FlxSprite
	{
		final tuman = group.recycle(FlxSprite);
		var newTexture = texture + FlxG.random.int(0, maxIndex);
		if (tuman.graphic == null || tuman.graphic.assetsKey.indexOf(newTexture) == -1)
			tuman.loadGraphic(Paths.image(newTexture));

		tuman.scrollFactor.set(FlxG.random.float(scrollFactor.x, scrollFactor.x * 1.2), FlxG.random.float(scrollFactor.y, scrollFactor.y * 1.01));
		tuman.scale.set(FlxG.random.float(scale, scale * 1.3), FlxG.random.float(scale, scale * 1.3));
		tuman.updateHitbox();
		tuman.x = (FlxG.random.float(x, x * 1.2) - tuman.width);

		var diff = 30;
		// do {
			tuman.y = FlxG.random.float(y, y + height);
		// } while (lastY != null && FlxMath.equal(lastY, tuman.y, diff));
		var delta = tuman.y - lastY;
		var deltaAbs = Math.abs(delta);
		if (deltaAbs < diff)
			tuman.y += (diff - deltaAbs) * FlxMath.signOf(delta);
		lastY = tuman.y;

		tuman.velocity.x = FlxG.random.float(velocity.x, velocity.y);
		@:bypassAccessor tuman.alpha = Math.max(FlxG.random.float(this.alpha, this.alpha * 2), 0);
		tuman.colorTransform.alphaMultiplier = tuman.alpha;
		tuman.flipX = FlxG.random.bool();
		tuman.flipY = FlxG.random.bool();
		tuman.blend = BlendMode.ADD;
		tuman.moves = true;

		if (FlxG.random.bool(JUMP_CHANCE))
		{
			var tween = FlxTween.tween(tuman, {y: tuman.y - FlxG.random.float(80, 120)}, FlxG.random.float(0.4, 0.8),
			{
				type: FlxTween.PINGPONG,
				onComplete: t -> t.ease = (t.backward ? FlxEase.sineOut : FlxEase.sineIn), ease: FlxEase.sineIn
			});
			goofyTweensOfGoofySprites.set(tuman, tween);
		}

		tuman.shader = shader;
		tuman.setColorTransform(colorTransform.redMultiplier, colorTransform.greenMultiplier, colorTransform.blueMultiplier, tuman.alpha * colorTransform.alphaMultiplier);

		return tuman;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		group.update(elapsed);

		final right = (x + width);
		for (tuman in group.members)
		{
			if (/*tuman.exists &&*/ tuman.alive && tuman.x > right)
			{
				if (goofyTweensOfGoofySprites.exists(tuman))
				{
					goofyTweensOfGoofySprites.get(tuman).cancel();
					goofyTweensOfGoofySprites.remove(tuman);
				}
				tuman.kill();
			}
		}

		timer += elapsed;
		if (timer >= spawnTime)
		{
			timer -= spawnTime;
			spawnTime = getSpawnTime();
			spawnTuman();
		}
	}

	override public function draw()
	{
		super.draw();
		group.draw();
	}

	override public function destroy()
	{
		super.destroy();
		group?.destroy();
		group = null;
	}

	override function updateMotion(elapsed:Float) {}

	function getSpawnTime():Float
	{
		return FlxG.random.float(minTime, maxTime);
	}

	function setShader(shader:FlxShader)
	{
		this.shader = shader;
		for (spr in group.members)
			spr.shader = shader;
	}

	function setColorTransform(?redMultiplier:Float, ?greenMultiplier:Float, ?blueMultiplier:Float, ?alphaMultiplier:Float)
	{
		var oldAlphaMult = colorTransform.alphaMultiplier;
		colorTransform.redMultiplier = redMultiplier ?? 1;
		colorTransform.greenMultiplier = greenMultiplier ?? 1;
		colorTransform.blueMultiplier = blueMultiplier ?? 1;
		colorTransform.alphaMultiplier = alphaMultiplier ?? 1;
		for (spr in group.members)
			spr.setColorTransform(colorTransform.redMultiplier, colorTransform.greenMultiplier, colorTransform.blueMultiplier, spr.alpha / oldAlphaMult * colorTransform.alphaMultiplier);
	}
}

class LampLight extends FlxSprite
{
	var targetAlpha:Float;
	var alphaTimer:Float;
	var lamp:FlxSprite;

	public function new(x = 0, y = 0, texture:String, ?parent:FlxSprite)
	{
		super(x, y, Paths.image(texture));
		blend = BlendMode.ADD;
		alpha = randomAlpha();
		targetAlpha = randomAlpha();
		alphaTimer = randomTimer();
		lamp = parent;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		alpha = CoolUtil.fpsLerp(alpha, targetAlpha, 0.12);
		if (lamp != null)
		{
			var c = Math.floor(191.25 + 63.75 * (1 - alpha));
			lamp.color = FlxColor.fromRGB(c, c, c);
		}

		alphaTimer -= elapsed;
		if (alphaTimer <= 0)
		{
			targetAlpha = randomAlpha();
			alphaTimer += randomTimer();
		}
	}

	override function set_alpha(value:Float):Float
	{
		@:bypassAccessor alpha = FlxMath.bound(value, 0, 1);
		colorTransform.alphaMultiplier = alpha;
		// dirty = true;
		return alpha;
	}

	function randomAlpha():Float
		return FlxG.random.float(0.45, 0.9);

	function randomTimer():Float
		return FlxG.random.float(0.075, 0.35);
}