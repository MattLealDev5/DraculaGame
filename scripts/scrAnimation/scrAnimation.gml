function AnimationController(spr) {
	var anim =
	{
	    sprite : spr,
	    frame : 0,
		frameSpeed : sprite_get_speed(spr),
		numOfFrames : sprite_get_number(spr)
	};
	return anim
}

function PlayAnimation(animCont) {
	with (animCont) {
		frame = (frame+frameSpeed/60) % numOfFrames
	}
}

function ChangeAnimation(animCont, spr) {
	with (animCont) {
	    sprite = spr
	    frame = 0
		frameSpeed = sprite_get_speed(spr)
		numOfFrames = sprite_get_number(spr)
	}
}