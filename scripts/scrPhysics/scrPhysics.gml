function HandleMovementX(xSpd) {
	x += xSpd
	if place_meeting(x, y, tileMapID) {
		var xInc = -sign(xSpd)
		while place_meeting(x, y, tileMapID) {
			x += xInc
		}
	}
}

function HandleMovementY(ySpd) {
	y -= ySpd
	if place_meeting(x, y, tileMapID) {
		var yInc = -sign(ySpd)
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
			//y = standing.y
			state = groundState
			grounded = true
			currGravity = 0
		}
	}
	
	// Passthrough
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
	}
}

function CheckPassThrough() {
	var passThrough = instance_place(x, y+1, oPassThrough)
	return passThrough && y < passThrough.y
}