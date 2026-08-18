animCont = new AnimationController(sPlayer)
mask_index = mskPlayer
tileMapID = layer_tilemap_get_id("Blocks");
camera = instance_find(oCamera, 0)

hp = 30
damage = 10

takeDamage = function(dmg) {
	hp -= dmg
	if hp <= 0 {
		die()
	}
}
die = function() {
	instance_destroy()
}

moveSpeed = 0
facing = -1
fallsOff = false

moveState = function() {
	if moveSpeed > 0 {
		x += facing*moveSpeed
	
		var width = 16
		var height = 16
	
		var posY = y-height/2
	
		var checkX = x + facing*width/2
		var checkY = posY + height
	
		if !fallsOff {
			var wallCheck = position_meeting(checkX, posY, tileMapID),
				edgeCheck = !position_meeting(checkX, checkY, tileMapID)
		
			if wallCheck || edgeCheck {
				show_debug_message($"Wall Check: {wallCheck}")
				show_debug_message($"Edge Check: {edgeCheck}")
				show_debug_message("\n")
				facing = -facing
			}
		}
	}
}