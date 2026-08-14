function AnimationController(spr) {
	var anim =
	{
	    sprite : spr,
	    frame : 0,
		frameSpeed : sprite_get_speed(spr),
		numOfFrames : sprite_get_number(spr),
		playAnimation : function() {
			frame = (frame+frameSpeed/60) % numOfFrames
		},
		changeAnimation : function(_sprite) {
			sprite = _sprite
		    frame = 0
			frameSpeed = sprite_get_speed(_sprite)
			numOfFrames = sprite_get_number(_sprite)
		}
	};
	return anim
}