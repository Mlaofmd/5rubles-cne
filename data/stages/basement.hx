function portCreate(){
	members[3].scrollFactor.set(0.8,0.8);
}

function onStartCountdown(ev){
    strumLines.members[3].camera = camGame; 

    for (strumNote in strumLines.members[3].members){
        strumNote.scrollFactor.set(0.8,0.8);
        strumNote.x += 200; // позиции сама выставишь
        strumNote.y += 60;
        strumNote.alpha = 0.5;
}
    for (strumNote in strumLines.members[0].members){
        strumNote.alpha = 0.5;
	}
    for (strumNote in strumLines.members[2].members){
        strumNote.alpha = 0.5;
    }
}
