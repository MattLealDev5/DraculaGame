function HandleMovementX(xSpd) {
	x += xSpd
	if place_meeting(x, y, tileMapID) {
		var xInc = -sign(facing)
		while place_meeting(x, y, tileMapID) {
			x += xInc
		}
	}
}

function HandleMovementY(ySpd) {
	y -= ySpd
	if place_meeting(x, y, tileMapID) {
		var yInc = -sign(ySpd)
		if yInc == 0 { yInc=1 }
		while place_meeting(x, y, tileMapID) {
			y -= yInc
		}
		
		var ceiling = instance_place(x, y-1, tileMapID)
		if ceiling {
			//y = ceiling.y + ceiling.sprite_height + sprite_height
			currGravity = 0
		}
		
		var standing = instance_place(x, y+1, tileMapID)
		if standing {
			move_snap(0, 16);
			enterGroundState()
		}
	}
	
	// Passthrough (Currently unused, figure out later if so desired)
	// Will probably reuse it for object collisions and shizzamzos
	var standingP = instance_place(x, y+1, oPassThrough)
	if standingP && y < standingP.y {
		var yInc = -sign(ySpd)
		while place_meeting(x, y, oPassThrough) {
			y -= yInc
		}
		
		//y = standingP.y
		state = groundState
		grounded = true
		currGravity = 0
	}
}

function CheckIfWalkOffEdge() {
	if !place_meeting(x, y+1, tileMapID) && !CheckPassThrough()  {
		grounded = false
		state = airState
		return true
	}
	return false
}

function CheckPassThrough() {
	var passThrough = instance_place(x, y+1, oPassThrough)
	return passThrough && y < passThrough.y
}