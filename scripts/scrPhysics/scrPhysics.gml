function HandleMovementX(xSpd) {
	x += xSpd
	if place_meeting(x, y, oPlatform) {
		var xInc = -sign(xSpd)
		while place_meeting(x, y, oPlatform) {
			x += xInc
		}
	}
}

function HandleMovementY(ySpd) {
	y -= ySpd
	if place_meeting(x, y, oPlatform) {
		var yInc = -sign(ySpd)
		while place_meeting(x, y, oPlatform) {
			y -= yInc
		}
		
		var ceiling = instance_place(x, y-1, oPlatform)
		if ceiling {
			y = ceiling.y + ceiling.sprite_height + sprite_height
			currGravity = 0
		}
		
		var standing = instance_place(x, y+1, oPlatform)
		if standing {
			y = standing.y
			state = groundState
			grounded = true
			currGravity = 0
		}
	}
}

function CheckIfWalkOffEdge() {
	if !place_meeting(x, y+1, oPlatform) {
		grounded = false
		state = airState
	}
}