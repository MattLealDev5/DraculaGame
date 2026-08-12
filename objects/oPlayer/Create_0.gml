animCont = AnimationController(sPlayer)
facing = 1

walkSpeed = 1
currWalkSpeed = 0

slideSpeed = 2
slideTimer = 0
slideTimerSet = 22
slideJumpFacing = 1

jumpForce = 2.5
slideJumpForce = 3
currGravity = 0
incrementGravity = 0.1
grounded = false
coyoteTime = 0
coyoteTimeSet = 8

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
	ChangeAnimation(animCont, sPlayer)
	mask_index = mskPlayer
	grounded = true
	currGravity = 0
	coyoteTime = coyoteTimeSet
	state = groundState
}
groundState = function() {
	var horizontalInput = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	var jumpInput = keyboard_check_pressed(ord("P"))
	var shootInput = keyboard_check_pressed(ord("L"))
	var slideInput = keyboard_check(ord("S"))
	
	if horizontalInput != 0 { enterWalkingState() }
	if jumpInput {
		if slideInput { enterSlideState() }
		else { enterAirState() }
	}
	if shootInput { shootBullet() }
	
	if CheckIfWalkOffEdge() {
		enterAirState(false)
	}
}
#endregion

#region Walking State
enterWalkingState = function() {
	ChangeAnimation(animCont, sPlayer_Walk)
	mask_index = mskPlayer
	grounded = true
	currGravity = 0
	state = walkingState
}
walkingState = function() {
	var horizontalInput = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	var jumpInput = keyboard_check_pressed(ord("P"))
	var shootInput = keyboard_check_pressed(ord("L"))
	var slideInput = keyboard_check(ord("S"))
	
	currWalkSpeed = horizontalInput * walkSpeed
	if horizontalInput != 0 { facing = horizontalInput }
	else { enterGroundState() }
	if jumpInput {
		if slideInput { enterSlideState() }
		else { enterAirState() }
	}
	if shootInput { shootBullet() }
	
	HandleMovementX(currWalkSpeed)
	if CheckIfWalkOffEdge() {
		enterAirState(false)
	}
}
#endregion

#region Airbourne State
enterAirState = function(jump = true) {
	ChangeAnimation(animCont, sPlayer_Jump)
	mask_index = mskPlayer
	currGravity = jump ? jumpForce : 0
	coyoteTime = jump ? 0 : coyoteTime
	grounded = false
	state = airState
}
airState = function() {
	var horizontalInput = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	var jumpInput = keyboard_check_pressed(ord("P"))
	var jumpReleased = keyboard_check_released(ord("P"))
	var shootInput = keyboard_check_pressed(ord("L"))
	
	if coyoteTime > 0 {
		if jumpInput {
			currGravity = jumpForce
			coyoteTime = 0
		}
		coyoteTime--
	}
	currGravity -= incrementGravity
	currWalkSpeed = horizontalInput * walkSpeed
	if horizontalInput != 0 { facing = horizontalInput }
	if currGravity > 0 && jumpReleased { currGravity = 0 }
	if shootInput { shootBullet() }
	
	HandleMovementX(currWalkSpeed)
	HandleMovementY(currGravity)
}
#endregion

#region Slide State
enterSlideState = function() {
	ChangeAnimation(animCont, sPlayer_Slide)
	mask_index = mskPlayer_Slide
	slideTimer = slideTimerSet
	currWalkSpeed = 0
	state = slideState
}
slideState = function() {
	var horizontalInput = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	var jumpInput = keyboard_check_pressed(ord("P"))
	
	HandleMovementX(slideSpeed*facing)
	if CheckIfWalkOffEdge() {
		if coyoteTime <= 0 { enterAirState(false) }
		coyoteTime--
	}
	slideTimer--;
	
	if place_meeting(x, y-9, tileMapID) {
		if horizontalInput != 0 { facing = horizontalInput }
	} else {
		if jumpInput {
			enterSlideJumpState()
		}
		
		if horizontalInput != 0 && horizontalInput != facing {
			facing = horizontalInput
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
	ChangeAnimation(animCont, sPlayer_Jump)
	mask_index = mskPlayer
	currGravity = slideJumpForce;
	grounded = false
	slideJumpFacing = facing
	state = slideJumpState
}
slideJumpState = function() {
	var horizontalInput = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	var jumpReleased = keyboard_check_released(ord("P"))
	var shootInput = keyboard_check_pressed(ord("L"))
	
	currGravity -= incrementGravity
	if horizontalInput != 0 { facing = horizontalInput }
	if currGravity > 0 && jumpReleased { currGravity = 0 }
	if shootInput { shootBullet() }
	
	HandleMovementX(slideSpeed*slideJumpFacing)
	HandleMovementY(currGravity)
}
#endregion

state = airState