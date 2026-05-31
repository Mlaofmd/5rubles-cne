import flixel.tweens.FlxTweenManager;
import flixel.util.FlxSort;

var cameraTweenManager = new FlxTweenManager();
var _tweens:Map<Int, FlxTween> = [];
var _defaultZoom:Float;

function create() {
	_defaultZoom = defaultCamZoom;

	for (i => event in events) {
        if (event.name == 'Cool Camera Zoom') {
            var newEvent = {
                name: event.name,
                time: event.time - Math.max(event.params[3] * Conductor.stepCrochet, 0),
                params: event.params
            };
            events[i] = newEvent;
        }
    }

    events.sort(function(p1, p2) {
        return FlxSort.byValues(FlxSort.DESCENDING, p1.time, p2.time); // fixes the time event after restarting the song - Mlaofmd
    });
}


function onEvent(eventEvent) {
	var params:Array = eventEvent.event.params;
	if (eventEvent.event.name == "Cool Camera Zoom") {
		var cam = params[6] == "camHUD" ? camHUD : camGame;
		var defaultZoom:Float;
		var curDefZoom:Float;
		switch(params[6]){
			case "camHUD":
				defaultZoom = 1;
				curDefZoom = defaultCamHUDZoom;
			default:
				defaultZoom = _defaultZoom;
				curDefZoom = defaultCamZoom;
		}
		
		var flxease:String = params[4] + (params[4] == "linear" ? "" : params[5]);
		var time:Float = params[3] * Conductor.stepCrochet / 1000;
		
		var tween = _tweens.get(cam.zoom);
		if (tween != null) tween.cancel();

		var addZoom = params[0];
		var bumpZoom = params[1];

		var finalZoom:Float = defaultZoom * (params[7] == 'direct' ? FlxCamera.defaultZoom : stage.defaultZoom);
		_tweens[cam.ID] = FlxTween.tween(cam, {zoom: finalZoom + addZoom}, time, {
			ease: Reflect.field(FlxEase, flxease),
			onComplete: _ ->
			{
				switch (params[2])
				{
					case "mode2":
						// ГОЙДААААААААА!!!!!! (ничего не происходит)

					default:
						switch (cam)
						{
							case camHUD: defaultHudZoom = cam.zoom;
							default: defaultCamZoom = cam.zoom;
						}
				}
					cam.zoom += bumpZoom;
			}
		});
	}
}

function postUpdate(elapsed){
	cameraTweenManager.update(elapsed);
}

function destroy(){
	cameraTweenManager.destroy();
}