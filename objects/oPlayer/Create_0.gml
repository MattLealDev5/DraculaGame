animCont = new AnimationController(sPlayer)
inputCont = new InputController()

facing = 1

walkSpeed = 1
currWalkSpeed = 0

slideSpeed = 2
slideTimer = 0; slideTimerSet = 22
slideJumpFacing = 1

jumpForce = 2.5
slideJumpForce = 3
currGravity = 0
incrementGravity = 0.1
grounded = false
coyoteTime = 0; coyoteTimeSet = 5

hurtTimer = 0; hurtTimerSet = 30
hurtInvincibility = 0; hurtInvincibilitySet = 90

#region Health and Damage
hp = 30
alive = true

takeDamage = function(dmg) {
	hp -= dmg
	if hp <= 0 {
		enterDeathState()
	} else {
		enterHurtState()
	}
}
#endregion

#region Shooting
bulletBank = [instance_create_layer(x, y, "Instances", oBullet),
			  instance_create_layer(x, y, "Instances", oBullet),
			  instance_create_layer(x, y, "Instances", oBullet)]
shootBullet = function() {
	var shot = array_pop(bulletBank)
	if !is_undefined(shot) {
		shot.x = x+10*facing
		shot.y = y-9
		shot.facing = facing
		shot.active = true
		shot.mask_index = mskBullet_Small
	}
}
returnBullet = function(shot) {
	shot.active = false
	array_push(bulletBank, shot)
}
#endregion


tileMapID = layer_tilemap_get_id("Blocks");


#region Grounded State
enterGroundState = function() {
	animCont.changeAnimation(sPlayer)
	mask_index = mskPlayer
	grounded = true
	currGravity = 0
	coyoteTime = coyoteTimeSet
	state = groundState
}
groundState = function() {
	if inputCont.walkDir() != 0 {
		facing = inputCont.walkDir()
		enterWalkingState()
	}
	if inputCont.jump() {
		if inputCont.slide() { enterSlideState() }
		else { enterJumpState() }
	}
	if inputCont.shoot() { shootBullet() }
	
	if CheckIfWalkOffEdge() {
		enterAirState()
	}
}
#endregion

#region Walking State
enterWalkingState = function() {
	animCont.changeAnimation(sPlayer_Walk)
	mask_index = mskPlayer
	grounded = true
	currGravity = 0
	state = walkingState
}
walkingState = function() {
	currWalkSpeed = inputCont.walkDir() * walkSpeed
	if inputCont.walkDir() != 0 { facing = inputCont.walkDir() }
	else { enterGroundState() }
	if inputCont.jump() {
		if inputCont.slide() { enterSlideState() }
		else { enterJumpState() }
	}
	if inputCont.shoot() { shootBullet() }
	
	HandleMovementX(currWalkSpeed)
	if CheckIfWalkOffEdge() {
		enterAirState()
	}
}
#endregion

#region Airbourne State
enterAirState = function() {
	animCont.changeAnimation(sPlayer_Jump)
	mask_index = mskPlayer
	currGravity = 0
	grounded = false
	state = airState
}
enterJumpState = function() {
	animCont.changeAnimation(sPlayer_Jump)
	mask_index = mskPlayer
	currGravity = jumpForce
	coyoteTime = 0
	grounded = false
	state = airState
}
airState = function() {
	if coyoteTime > 0 {
		if inputCont.jump() {
			currGravity = jumpForce
			coyoteTime = 0
		}
		coyoteTime--
	}
	currGravity -= incrementGravity
	currWalkSpeed = inputCont.walkDir() * walkSpeed
	if inputCont.walkDir() != 0 { facing = inputCont.walkDir() }
	if currGravity > 0 && inputCont.jumpRelease() { currGravity = 0 }
	if inputCont.shoot() { shootBullet() }
	
	HandleMovementX(currWalkSpeed)
	HandleMovementY(currGravity)
}
#endregion

#region Slide State
enterSlideState = function() {
	animCont.changeAnimation(sPlayer_Slide)
	mask_index = mskPlayer_Slide
	slideTimer = slideTimerSet
	currWalkSpeed = 0
	state = slideState
}
slideState = function() {
	HandleMovementX(slideSpeed*facing)
	if CheckIfWalkOffEdge() {
		if coyoteTime <= 0 { enterAirState() }
		coyoteTime--
	}
	slideTimer--;
	
	if place_meeting(x, y-9, tileMapID) {
		if inputCont.walkDir() != 0 { facing = inputCont.walkDir() }
	} else {
		if inputCont.jump() {
			enterSlideJumpState()
		}
		
		if inputCont.walkDir() != 0 && inputCont.walkDir() != facing {
			facing = inputCont.walkDir()
			enterGroundState()
		}
	
		if slideTimer <= 0 || place_meeting(x+facing, y, tileMapID) {
			enterGroundState()
		}
	}
}
#endregion

#region Slide Jump State
enterSlideJumpState = function() {
	animCont.changeAnimation(sPlayer_Jump)
	mask_index = mskPlayer
	currGravity = slideJumpForce;
	grounded = false
	slideJumpFacing = facing
	state = slideJumpState
}
slideJumpState = function() {
	currGravity -= incrementGravity
	if inputCont.walkDir() != 0 { facing = inputCont.walkDir() }
	if currGravity > 0 && inputCont.jumpRelease() { currGravity = 0 }
	if inputCont.shoot() { shootBullet() }
	
	HandleMovementX(slideSpeed*slideJumpFacing)
	HandleMovementY(currGravity)
}
#endregion

#region Hurt State
enterHurtState = function() {
	animCont.changeAnimation(sPlayer_Jump)
	mask_index = mskPlayer
	currGravity = 0;
	grounded = false
	hurtTimer = hurtTimerSet
	hurtInvincibility = hurtInvincibilitySet
	state = hurtState
}
hurtState = function() {
	currGravity -= incrementGravity
	
	HandleMovementX(-facing*walkSpeed/2)
	//HandleMovementY(currGravity)
	
	hurtTimer--
	if hurtTimer <= 0 {
		enterAirState()
	}
}
#endregion


#region Death State
enterDeathState = function() {
	alive = false
	state = deathState
}
deathState = function() {
	// you dead boi
}
#endregion

state = airState