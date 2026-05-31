var jpegShd = new CustomShader('jpeg_lite');
var colors:Float = 100;
var pixels:Float = 0.05;
var colorsLerp:Float = 100;
var pixelsLerp:Float = 0.05;
var lerpTime:Float = 1;

function create(){
    jpegShd.cellSize = 0.05;
    jpegShd.colors = 1000;
    jpegShd.crustFactor = 0;

    redarCam.addShader(jpegShd);

    colors = 1000;
	pixels = 0;
	colorsLerp = 1000;
	pixelsLerp = 0;
}


function update(elapsed:Float){
    colorsLerp = lerp(colorsLerp, colors, 1 / (0.05 * Conductor.stepCrochet * lerpTime));
	pixelsLerp = lerp(pixelsLerp, pixels, 1 / (0.05 * Conductor.stepCrochet * lerpTime));

	jpegShd.cellSize = pixelsLerp;
	jpegShd.colors = colorsLerp;
	jpegShd.crustFactor = 0;
}

function onEvent(ev){
	var params = ev.event.params;
	if(ev.event.name == "lag"){
		colors = params[0] * 10;
		pixels = params[1];
		lerpTime = params[2];
	}
}