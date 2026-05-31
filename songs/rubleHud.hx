public var isHudActivated:Bool = PlayState.SONG.meta.name != 'under-construction' ? true : false;

// timer
var timerMin:FlxSprite;
var timerTenSec:FlxSprite;
var timerSec:FlxSprite;
var songMin:FlxSprite;
var songTenSec:FlxSprite;
var songSec:FlxSprite;
var songSlash:FlxSprite;
var timeIcon:FlxSprite;
var dotsTimer:FlxSprite;
var dotsSong:FlxSprite;
var dotsIcon:FlxSprite;
var songStarted:Bool = false;

// scoreTxt
var scoreIcon:FlxSprite;
var dotsScore:FlxSprite;
var num1Score:FlxSprite;
var num2Score:FlxSprite;
var num3Score:FlxSprite;
var num4Score:FlxSprite;
var num5Score:FlxSprite;
var num6Score:FlxSprite;
var num7Score:FlxSprite;
var bigDotScore:FlxSprite;

// missTxt
var missIcon:FlxSprite;
var dotsMiss:FlxSprite;
var num1Miss:FlxSprite;
var num2Miss:FlxSprite;
var num3Miss:FlxSprite;
var num4Miss:FlxSprite;
var bigDotMiss:FlxSprite;

// acc
var accuracity:String = "0";
var accIcon:FlxSprite;
var dotsAcc:FlxSprite;
var num1Acc:FlxSprite;
var num2Acc:FlxSprite;
var num3Acc:FlxSprite;
var num4Acc:FlxSprite;
var num5Acc:FlxSprite;
var accDot:FlxSprite;

// cameraMove
var camOffsetX:Float = 0;
var camOffsetY:Float = 0;
var camOffsetLerpX:Float = 0;
var camOffsetLerpY:Float = 0;
var mustHitSection:Bool = false;
var _speedTimer = 0.0;

function onStartCountdown() {
	if (isHudActivated) {
		createRubleHud();
	}
}

public function createRubleHud() {
	accuracyTxt.visible = false;
	scoreTxt.visible = false;
	missesTxt.visible = false;

	timerMin = new FlxSprite(-1000, 0);
	timerMin.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	timerTenSec = new FlxSprite(-1000, 0);
	timerTenSec.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	timerSec = new FlxSprite(-1000, 0);
	timerSec.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	songMin = new FlxSprite(-1000, 0);
	songMin.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	songTenSec = new FlxSprite(-1000, 0);
	songTenSec.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	songSec = new FlxSprite(-1000, 0);
	songSec.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	songSlash = new FlxSprite(-1000, 0);
	songSlash.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	timeIcon = new FlxSprite(-1000, 0);
	timeIcon.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	dotsTimer = new FlxSprite(-1000, 0);
	dotsTimer.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	dotsSong = new FlxSprite(-1000, 0);
	dotsSong.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	dotsIcon = new FlxSprite(-1000, 0);
	dotsIcon.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	add(timerMin);
	add(timerTenSec);
	add(timerSec);
	add(songMin);
	add(songTenSec);
	add(songSec);
	add(songSlash);
	add(timeIcon);
	add(dotsTimer);
	add(dotsSong);
	add(dotsIcon);

	addAnimationForNumbers(timerMin);
	addAnimationForNumbers(timerTenSec);
	addAnimationForNumbers(timerSec);
	addAnimationForNumbers(songMin);
	addAnimationForNumbers(songTenSec);
	addAnimationForNumbers(songSec);

	songSlash.animation.addByPrefix('slash', 'slash', 1, false);
	timeIcon.animation.addByPrefix('time', 'time', 1, false);
	dotsTimer.animation.addByPrefix('doubledot', 'doubledot', 1, false);
	dotsSong.animation.addByPrefix('doubledot', 'doubledot', 1, false);
	dotsIcon.animation.addByPrefix('doubledot', 'doubledot', 1, false);

	timerMin.cameras = [camHUD];
	timerTenSec.cameras = [camHUD];
	timerSec.cameras = [camHUD];
	songMin.cameras = [camHUD];
	songTenSec.cameras = [camHUD];
	songSec.cameras = [camHUD];
	songSlash.cameras = [camHUD];
	timeIcon.cameras = [camHUD];
	dotsTimer.cameras = [camHUD];
	dotsSong.cameras = [camHUD];
	dotsIcon.cameras = [camHUD];

	songSec.animation.play('0');
	songTenSec.animation.play('0');
	songMin.animation.play('0');
	timerSec.animation.play('0');
	timerTenSec.animation.play('0');
	timerMin.animation.play('0');
	songSlash.animation.play('slash');
	timeIcon.animation.play('time');
	dotsTimer.animation.play('doubledot');
	dotsSong.animation.play('doubledot');
	dotsIcon.animation.play('doubledot');

	scoreIcon = new FlxSprite(-1000, 0);
	scoreIcon.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	dotsScore = new FlxSprite(-1000, 0);
	dotsScore.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	bigDotScore = new FlxSprite(-1000, 0);
	bigDotScore.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	num1Score = new FlxSprite(-1000, 0);
	num1Score.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	num2Score = new FlxSprite(-1000, 0);
	num2Score.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	num3Score = new FlxSprite(-1000, 0);
	num3Score.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	num4Score = new FlxSprite(-1000, 0);
	num4Score.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	num5Score = new FlxSprite(-1000, 0);
	num5Score.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	num6Score = new FlxSprite(-1000, 0);
	num6Score.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	num7Score = new FlxSprite(-1000, 0);
	num7Score.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	add(scoreIcon);
	add(dotsScore);
	add(bigDotScore);
	add(num1Score);
	add(num2Score);
	add(num3Score);
	add(num4Score);
	add(num5Score);
	add(num6Score);
	add(num7Score);

	scoreIcon.animation.addByPrefix('score', 'score', 1, false);
	dotsScore.animation.addByPrefix('doubledot', 'doubledot', 1, false);
	bigDotScore.animation.addByPrefix('bigdot', 'bigdot', 1, false);
	addAnimationForNumbers(num1Score);
	addAnimationForNumbers(num2Score);
	addAnimationForNumbers(num3Score);
	addAnimationForNumbers(num4Score);
	addAnimationForNumbers(num5Score);
	addAnimationForNumbers(num6Score);
	addAnimationForNumbers(num7Score);

	scoreIcon.cameras = [camHUD];
	dotsScore.cameras = [camHUD];
	bigDotScore.cameras = [camHUD];
	num1Score.cameras = [camHUD];
	num2Score.cameras = [camHUD];
	num3Score.cameras = [camHUD];
	num4Score.cameras = [camHUD];
	num5Score.cameras = [camHUD];
	num6Score.cameras = [camHUD];
	num7Score.cameras = [camHUD];

	scoreIcon.animation.play('score');
	dotsScore.animation.play('doubledot');
	bigDotScore.animation.play('bigdot');
	num1Score.animation.play('0');
	num2Score.animation.play('0');
	num3Score.animation.play('0');
	num4Score.animation.play('0');
	num5Score.animation.play('0');
	num6Score.animation.play('0');
	num7Score.animation.play('0');

	missIcon = new FlxSprite(-1000, 0);
	missIcon.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	dotsMiss = new FlxSprite(-1000, 0);
	dotsMiss.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	num1Miss = new FlxSprite(-1000, 0);
	num1Miss.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	num2Miss = new FlxSprite(-1000, 0);
	num2Miss.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	num3Miss = new FlxSprite(-1000, 0);
	num3Miss.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	num4Miss = new FlxSprite(-1000, 0);
	num4Miss.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	bigDotMiss = new FlxSprite(-1000, 0);
	bigDotMiss.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	add(missIcon);
	add(dotsMiss);
	add(num1Miss);
	add(num2Miss);
	add(num3Miss);
	add(num4Miss);
	add(bigDotMiss);

	addAnimationForNumbers(num1Miss);
	addAnimationForNumbers(num2Miss);
	addAnimationForNumbers(num3Miss);
	addAnimationForNumbers(num4Miss);
	missIcon.animation.addByPrefix('miss', 'miss', 1, false);
	dotsMiss.animation.addByPrefix('doubledot', 'doubledot', 1, false);
	bigDotMiss.animation.addByPrefix('bigdot', 'bigdot', 1, false);

	missIcon.cameras = [camHUD];
	dotsMiss.cameras = [camHUD];
	num1Miss.cameras = [camHUD];
	num2Miss.cameras = [camHUD];
	num3Miss.cameras = [camHUD];
	num4Miss.cameras = [camHUD];
	bigDotMiss.cameras = [camHUD];

	missIcon.animation.play('miss');
	dotsMiss.animation.play('doubledot');
	num1Miss.animation.play('0');
	num2Miss.animation.play('0');
	num3Miss.animation.play('0');
	num4Miss.animation.play('0');
	bigDotMiss.animation.play('bigdot');

	accIcon = new FlxSprite(-1000, 0);
	accIcon.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	dotsAcc = new FlxSprite(-1000, 0);
	dotsAcc.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	num1Acc = new FlxSprite(-1000, 0);
	num1Acc.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	num2Acc = new FlxSprite(-1000, 0);
	num2Acc.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	num3Acc = new FlxSprite(-1000, 0);
	num3Acc.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	num4Acc = new FlxSprite(-1000, 0);
	num4Acc.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	num5Acc = new FlxSprite(-1000, 0);
	num5Acc.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	accDot = new FlxSprite(-1000, 0);
	accDot.frames = Paths.getSparrowAtlas('game/hudTextStuff');

	add(accIcon);
	add(dotsAcc);
	add(num1Acc);
	add(num2Acc);
	add(num3Acc);
	add(num4Acc);
	add(num5Acc);
	add(accDot);

	addAnimationForNumbers(num1Acc);
	addAnimationForNumbers(num2Acc);
	addAnimationForNumbers(num3Acc);
	addAnimationForNumbers(num4Acc);
	addAnimationForNumbers(num5Acc);
	accIcon.animation.addByPrefix('percent', 'percent', 1, false);
	dotsAcc.animation.addByPrefix('doubledot', 'doubledot', 1, false);
	accDot.animation.addByPrefix('dot', 'dot', 1, false);
	accIcon.cameras = [camHUD];
	dotsAcc.cameras = [camHUD];
	num1Acc.cameras = [camHUD];
	num2Acc.cameras = [camHUD];
	num3Acc.cameras = [camHUD];
	num4Acc.cameras = [camHUD];
	num5Acc.cameras = [camHUD];
	accDot.cameras = [camHUD];

	accIcon.animation.play('percent');
	dotsAcc.animation.play('doubledot');
	num1Acc.animation.play('0');
	num2Acc.animation.play('0');
	num3Acc.animation.play('0');
	num4Acc.animation.play('0');
	num5Acc.animation.play('0');
	accDot.animation.play('dot');

	scoreIcon.x = -100;
	num1Acc.x = FlxG.width + 100;
	songStarted = true;
}

var songTimer:String = "0";

function update(elapsed) {
	if (!isHudActivated) return;
	
	if (songStarted) {
		songSec.x = healthBar.x + healthBar.width - songSec.width - 5;
		songSec.y = healthBar.y - healthBar.height - 25;
		songTenSec.x = songSec.x - 2 - songTenSec.width;
		songTenSec.y = songSec.y;
		dotsSong.x = songTenSec.x + 12 - dotsSong.width;
		dotsSong.y = songSec.y + 7;
		songMin.x = dotsSong.x - 2 - songMin.width;
		songMin.y = songSec.y;
		songSlash.x = songMin.x - 2 - songSlash.width;
		songSlash.y = songSec.y;
		timerSec.x = songSlash.x - 2 - timerSec.width;
		timerSec.y = songSec.y;
		timerTenSec.x = timerSec.x - 2 - timerTenSec.width;
		timerTenSec.y = songSec.y;
		dotsTimer.x = timerTenSec.x + 12 - dotsTimer.width;
		dotsTimer.y = songSec.y + 7;
		timerMin.x = dotsTimer.x - 2 - timerMin.width;
		timerMin.y = songSec.y;
		dotsIcon.x = timerMin.x + 8 - dotsIcon.width;
		dotsIcon.y = songSec.y + 7;
		timeIcon.x = dotsIcon.x - 10 - timeIcon.width;
		timeIcon.y = songSec.y;

		songTimer = Std.string(Math.floor((inst.time / 1000) % 60));

		timerSec.animation.play((songTimer.length > 1) ? songTimer.charAt(1) : songTimer.charAt(0));
		timerTenSec.animation.play((songTimer.length > 1) ? songTimer.charAt(0) : "0");
		timerMin.animation.play(Std.string(Math.floor(inst.time / 60000)));

		songSec.animation.play(Std.string(Math.floor((inst.length / 1000) % 60)).charAt(1));
		songTenSec.animation.play(Std.string(Math.floor((inst.length / 1000) % 60)).charAt(0));
		songMin.animation.play(Std.string(Math.floor(inst.length / 60000)).charAt(0));

		scoreIcon.x = FlxG.width / 2 - (num1Acc.x + num1Acc.width - scoreIcon.x - scoreIcon.width) / 2;
		scoreIcon.y = healthBar.y + 20;
		dotsScore.x = scoreIcon.x + dotsScore.width + 18;
		dotsScore.y = scoreIcon.y + 7;
		num7Score.x = dotsScore.x + num7Score.width - 10;
		num7Score.y = scoreIcon.y + 2;
		num6Score.x = num7Score.x + num6Score.width - 2;
		num6Score.y = scoreIcon.y + 2;
		num5Score.x = num6Score.x + num5Score.width - 2;
		num5Score.y = scoreIcon.y + 2;
		num4Score.x = num5Score.x + num4Score.width - 2;
		num4Score.y = scoreIcon.y + 2;
		num3Score.x = num4Score.x + num3Score.width - 2;
		num3Score.y = scoreIcon.y + 2;
		num2Score.x = num3Score.x + num2Score.width - 2;
		num2Score.y = scoreIcon.y + 2;
		num1Score.x = num2Score.x + num1Score.width - 2;
		num1Score.y = scoreIcon.y + 2;
		bigDotScore.y = num1Score.y + 8;

		switch (Std.string(songScore).length ?? "0") {
			case 1:
				num7Score.scale.x = 1;
				num6Score.scale.x = 0;
				num5Score.scale.x = 0;
				num4Score.scale.x = 0;
				num3Score.scale.x = 0;
				num2Score.scale.x = 0;
				num1Score.scale.x = 0;

				num7Score.animation.play(Std.string(songScore).charAt(0));
				bigDotScore.x = num7Score.x + bigDotScore.width + 7;
			case 2:
				num7Score.scale.x = 1;
				num6Score.scale.x = 1;
				num5Score.scale.x = 0;
				num4Score.scale.x = 0;
				num3Score.scale.x = 0;
				num2Score.scale.x = 0;
				num1Score.scale.x = 0;

				num7Score.animation.play(Std.string(songScore).charAt(0));
				num6Score.animation.play(Std.string(songScore).charAt(1));
				bigDotScore.x = num6Score.x + bigDotScore.width + 7;
			case 3:
				num7Score.scale.x = 1;
				num6Score.scale.x = 1;
				num5Score.scale.x = 1;
				num4Score.scale.x = 0;
				num3Score.scale.x = 0;
				num2Score.scale.x = 0;
				num1Score.scale.x = 0;

				num7Score.animation.play(Std.string(songScore).charAt(0));
				num6Score.animation.play(Std.string(songScore).charAt(1));
				num5Score.animation.play(Std.string(songScore).charAt(2));
				bigDotScore.x = num5Score.x + bigDotScore.width + 7;
			case 4:
				num7Score.scale.x = 1;
				num6Score.scale.x = 1;
				num5Score.scale.x = 1;
				num4Score.scale.x = 1;
				num3Score.scale.x = 0;
				num2Score.scale.x = 0;
				num1Score.scale.x = 0;

				num7Score.animation.play(Std.string(songScore).charAt(0));
				num6Score.animation.play(Std.string(songScore).charAt(1));
				num5Score.animation.play(Std.string(songScore).charAt(2));
				num4Score.animation.play(Std.string(songScore).charAt(3));
				bigDotScore.x = num4Score.x + bigDotScore.width + 7;
			case 5:
				num7Score.scale.x = 1;
				num6Score.scale.x = 1;
				num5Score.scale.x = 1;
				num4Score.scale.x = 1;
				num3Score.scale.x = 1;
				num2Score.scale.x = 0;
				num1Score.scale.x = 0;

				num7Score.animation.play(Std.string(songScore).charAt(0));
				num6Score.animation.play(Std.string(songScore).charAt(1));
				num5Score.animation.play(Std.string(songScore).charAt(2));
				num4Score.animation.play(Std.string(songScore).charAt(3));
				num3Score.animation.play(Std.string(songScore).charAt(4));
				bigDotScore.x = num3Score.x + bigDotScore.width + 7;
			case 6:
				num7Score.scale.x = 1;
				num6Score.scale.x = 1;
				num5Score.scale.x = 1;
				num4Score.scale.x = 1;
				num3Score.scale.x = 1;
				num2Score.scale.x = 1;
				num1Score.scale.x = 0;

				num7Score.animation.play(Std.string(songScore).charAt(0));
				num6Score.animation.play(Std.string(songScore).charAt(1));
				num5Score.animation.play(Std.string(songScore).charAt(2));
				num4Score.animation.play(Std.string(songScore).charAt(3));
				num3Score.animation.play(Std.string(songScore).charAt(4));
				num2Score.animation.play(Std.string(songScore).charAt(5));
				bigDotScore.x = num2Score.x + bigDotScore.width + 7;
			case 7:
				num7Score.scale.x = 1;
				num6Score.scale.x = 1;
				num5Score.scale.x = 1;
				num4Score.scale.x = 1;
				num3Score.scale.x = 1;
				num2Score.scale.x = 1;
				num1Score.scale.x = 1;

				num7Score.animation.play(Std.string(songScore).charAt(0));
				num6Score.animation.play(Std.string(songScore).charAt(1));
				num5Score.animation.play(Std.string(songScore).charAt(2));
				num4Score.animation.play(Std.string(songScore).charAt(3));
				num3Score.animation.play(Std.string(songScore).charAt(4));
				num2Score.animation.play(Std.string(songScore).charAt(5));
				num1Score.animation.play(Std.string(songScore).charAt(6));
				bigDotScore.x = num1Score.x + bigDotScore.width + 7;
		}

		// missTxt
		missIcon.x = bigDotScore.x + missIcon.width - 2;
		missIcon.y = scoreIcon.y;
		dotsMiss.x = missIcon.x + dotsMiss.width + 18;
		dotsMiss.y = missIcon.y + 7;
		num4Miss.x = dotsMiss.x + num4Miss.width - 10;
		num4Miss.y = missIcon.y + 2;
		num3Miss.x = num4Miss.x + num3Miss.width + 2;
		num3Miss.y = missIcon.y + 2;
		num2Miss.x = num3Miss.x + num2Miss.width + 2;
		num2Miss.y = missIcon.y + 2;
		num1Miss.x = num2Miss.x + num1Miss.width + 2;
		num1Miss.y = missIcon.y + 2;
		bigDotMiss.y = num1Miss.y + 8;

		switch (Std.string(misses).length ?? "0") {
			case 1:
				num1Miss.scale.x = 0;
				num2Miss.scale.x = 0;
				num3Miss.scale.x = 0;
				num4Miss.scale.x = 1;

				num4Miss.animation.play(Std.string(misses).charAt(0));
				bigDotMiss.x = num4Miss.x + bigDotMiss.width + 7;
			case 2:
				num1Miss.scale.x = 0;
				num2Miss.scale.x = 0;
				num3Miss.scale.x = 1;
				num4Miss.scale.x = 1;

				num4Miss.animation.play(Std.string(misses).charAt(0));
				num3Miss.animation.play(Std.string(misses).charAt(1));
				bigDotMiss.x = num3Miss.x + bigDotMiss.width + 7;
			case 3:
				num1Miss.scale.x = 0;
				num2Miss.scale.x = 1;
				num3Miss.scale.x = 1;
				num4Miss.scale.x = 1;

				num4Miss.animation.play(Std.string(misses).charAt(0));
				num3Miss.animation.play(Std.string(misses).charAt(1));
				num2Miss.animation.play(Std.string(misses).charAt(2));
				bigDotMiss.x = num2Miss.x + bigDotMiss.width + 7;
			case 4:
				num1Miss.scale.x = 1;
				num2Miss.scale.x = 1;
				num3Miss.scale.x = 1;
				num4Miss.scale.x = 1;

				num4Miss.animation.play(Std.string(misses).charAt(0));
				num3Miss.animation.play(Std.string(misses).charAt(1));
				num2Miss.animation.play(Std.string(misses).charAt(2));
				num1Miss.animation.play(Std.string(misses).charAt(3));
				bigDotMiss.x = num1Miss.x + bigDotMiss.width + 7;
		}

		accIcon.x = bigDotMiss.x + accIcon.width - 2;
		accIcon.y = missIcon.y;
		dotsAcc.x = accIcon.x + dotsAcc.width + 18;
		dotsAcc.y = accIcon.y + 7;
		num5Acc.x = dotsAcc.x + num5Acc.width - 10;
		num5Acc.y = accIcon.y + 2;
		num4Acc.y = accIcon.y + 2;
		num3Acc.y = accIcon.y + 2;
		num2Acc.y = accIcon.y + 2;
		num1Acc.y = accIcon.y + 2;
		accDot.y = accIcon.y + 23;
	}

	switch (Std.string(accuracity).length ?? "0") {
		case 1:
			num5Acc.scale.x = 1;
			num4Acc.scale.x = 0;
			num3Acc.scale.x = 0;
			num2Acc.scale.x = 0;
			num1Acc.scale.x = 0;
			accDot.scale.x = 0;

			num5Acc.animation.play('0');
			num1Acc.x = num5Acc.x;
		case 4:
			num5Acc.scale.x = 1;
			num4Acc.scale.x = 1;
			num3Acc.scale.x = 1;
			num2Acc.scale.x = 0;
			num1Acc.scale.x = 0;
			accDot.scale.x = 1;

			num5Acc.animation.play(Std.string(accuracity).charAt(0));
			num4Acc.animation.play(Std.string(accuracity).charAt(2));
			num3Acc.animation.play(Std.string(accuracity).charAt(3));

			accDot.x = num5Acc.x + accDot.width + 2;
			num4Acc.x = accDot.x + num4Acc.width - 11;
			num3Acc.x = num4Acc.x + num3Acc.width + 2;
			num1Acc.x = num3Acc.x;
		case 5:
			num5Acc.scale.x = 1;
			num4Acc.scale.x = 1;
			num3Acc.scale.x = 1;
			num2Acc.scale.x = 1;
			num1Acc.scale.x = 0;
			accDot.scale.x = 1;

			num5Acc.animation.play(Std.string(accuracity).charAt(0));
			num4Acc.animation.play(Std.string(accuracity).charAt(1));
			num3Acc.animation.play(Std.string(accuracity).charAt(3));
			num2Acc.animation.play(Std.string(accuracity).charAt(4));

			num4Acc.x = num5Acc.x + num4Acc.width + 2;
			accDot.x = num4Acc.x + accDot.width + 2;
			num3Acc.x = accDot.x + num3Acc.width - 11;
			num2Acc.x = num3Acc.x + num2Acc.width + 2;
			num1Acc.x = num2Acc.x;
		case 6:
			num5Acc.scale.x = 1;
			num4Acc.scale.x = 1;
			num3Acc.scale.x = 1;
			num2Acc.scale.x = 1;
			num1Acc.scale.x = 1;
			accDot.scale.x = 1;

			num5Acc.animation.play(Std.string(accuracity).charAt(0));
			num4Acc.animation.play(Std.string(accuracity).charAt(1));
			num3Acc.animation.play(Std.string(accuracity).charAt(2));
			num2Acc.animation.play(Std.string(accuracity).charAt(3));
			num1Acc.animation.play(Std.string(accuracity).charAt(4));
			num4Acc.x = num5Acc.x + num4Acc.width + 2;
			num3Acc.x = num4Acc.x + num3Acc.width + 2;
			accDot.x = num3Acc.x + accDot.width + 2;
			num2Acc.x = accDot.x + num2Acc.width - 11;
			num1Acc.x = num2Acc.x + num4Acc.width + 2;
	}
}

function onPlayerHit(ev) {
	_speedTimer = 1;
}

function calcAcc() {
	var tallies = Highscore.tallies;
	var notesHit = tallies.sick + tallies.good + tallies.bad + tallies.shit + tallies.missed;
	var grade = ((tallies.sick + tallies.good) / notesHit);
	accuracity = Std.string(Math.max(FlxMath.roundDecimal(grade * 100, 2), 0));
	if (accuracity == '-nan(ind)') {
		accuracity = "0";
	} else if (accuracity.indexOf('.') == -1) {
		accuracity = accuracity + ".00";
	} else if (accuracity.length - accuracity.indexOf('.') == 2) {
		accuracity = accuracity + '0';
	}
}

function addAnimationForNumbers(sprite:FlxSprite) {
	for (i in 0...10) {
		sprite.animation.addByPrefix(Std.string(i), Std.string(i), 1, false);
	}
}
