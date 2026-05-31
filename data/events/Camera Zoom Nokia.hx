
var redarZoomTween:FlxTween;
var zorkaZoomTween:FlxTween;

function onEvent(eventEvent) {
	var params:Array = eventEvent.event.params;
	if (eventEvent.event.name == "Camera Zoom Nokia") {
		if (params[0]) {
			var flxease:String = params[3] + (params[3] == "linear" ? "" : params[4]);
			
			if (params[5] == 'redarCam') {
				if (redarZoomTween != null)
					redarZoomTween.cancel();
				redarZoomTween = FlxTween.tween(redarCam, {zoom: params[1]}, (Conductor.stepCrochet / 1000) * params[2], {ease: Reflect.field(FlxEase, flxease)});
			} else if (params[5] == 'zorkaCam') {
				if (zorkaZoomTween != null)
					zorkaZoomTween.cancel();
				zorkaZoomTween = FlxTween.tween(zorkaCam, {zoom: params[1]}, (Conductor.stepCrochet / 1000) * params[2], {ease: Reflect.field(FlxEase, flxease)});
			}
		} else {
			if (params[5] == 'redarCam')
				redarCam.zoom = params[1];
			else if (params[5] == 'zorkaCam')
				zorkaCam.zoom = params[1];
		}
	}
}
