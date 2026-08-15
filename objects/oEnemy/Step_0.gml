if walkSpeed > 0 {
	x += facing*walkSpeed
	
	var width = 16
	var height = 16
	
	var posY = y-height/2
	
	var checkX = x + facing*width/2
	var checkY = posY + height
	
	var wallCheck = position_meeting(checkX, posY, tileMapID),
		edgeCheck = !position_meeting(checkX, checkY, tileMapID)
		
	if wallCheck || edgeCheck {
		show_debug_message($"Wall Check: {wallCheck}")
		show_debug_message($"Edge Check: {edgeCheck}")
		show_debug_message("\n")
		facing = -facing
	}
}