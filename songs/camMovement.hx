import flixel.math.FlxBasePoint;

public var isCamMove:Bool = true;
public var moveStrength:Float = 15;
var movement = new FlxBasePoint();

function onCameraMove(ev){
    if(isCamMove){
        if(ev.strumLine != null && ev.strumLine?.characters[0] != null){
            switch(ev.strumLine.characters[0].animation.name){
                case "singDOWN", "singDOWN-alt", "singDOWN-bzd": movement.set(0, moveStrength);
                case "singUP", "singUP-alt", "singUP-bzd": movement.set(0, -moveStrength);
                case "singLEFT", "singLEFT-alt", "singLEFT-bzd": movement.set(-moveStrength, 0);
                case "singRIGHT", "singRIGHT-alt", "singRIGHT-bzd": movement.set(moveStrength, 0);
                default: movement.set(0, 0);
            };

            ev.position.x += movement.x;
            ev.position.y += movement.y;
        }
    }
}