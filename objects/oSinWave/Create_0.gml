event_inherited()

animCont = new AnimationController(sPlayer)
mask_index = mskPlayer

hp = 30
facing = -1
moveSpeed = 1

startingPosY = y
rangeY = 40
stepY = 0
stepYInc = 2

moveState = function() {
	x += facing*moveSpeed
	
	stepY += stepYInc
	var yPos = sin(degtorad(stepY))*rangeY + startingPosY
	y = yPos
	
	if x < camera.cameraX {
		instance_destroy()
	}
}