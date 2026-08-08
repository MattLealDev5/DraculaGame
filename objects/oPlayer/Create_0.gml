sprite = sPlayer
facing = 1

walkSpeed = 1
currWalkSpeed = 0

slideSpeed = 2
slideTimer = 0
slideTimerSet = 22

jumpForce = 3
currGravity = 0
grounded = false

tileMapID = layer_tilemap_get_id("Blocks");


#region Grounded State
enterGroundState = function() {
	sprite = sPlayer
	mask_index = mskPlayer
	grounded = true
	currGravity = 0
	state = groundState
}
groundState = function() {
	var horizontalInput = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	var jumpInput = keyboard_check_pressed(ord("P"))
	var slideInput = keyboard_check(ord("S"))
	
	currWalkSpeed = horizontalInput * walkSpeed
	if horizontalInput != 0 { facing = horizontalInput }
	if jumpInput {
		if slideInput { enterSlideState() }
		else { enterAirState() }
	}
	
	HandleMovementX(currWalkSpeed)
	CheckIfWalkOffEdge()
}
#endregion

#region Airbourne State
enterAirState = function() {
	//sprite = sPlayer
	mask_index = mskPlayer
	currGravity = jumpForce;
	grounded = false
	state = airState
}
airState = function() {
	var horizontalInput = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	var jumpReleased = keyboard_check_released(ord("P"))
	
	currGravity -= 0.1
	currWalkSpeed = horizontalInput * walkSpeed
	if horizontalInput != 0 { facing = horizontalInput }
	if currGravity > 0 && jumpReleased { currGravity = 0 }
	
	HandleMovementX(currWalkSpeed)
	HandleMovementY(currGravity)
}
#endregion

#region Slide State
enterSlideState = function() {
	sprite = sPlayer_Slide
	mask_index = mskPlayer_Slide
	slideTimer = slideTimerSet
	currWalkSpeed = 0
	state = slideState
}
slideState = function() {
	var horizontalInput = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	var jumpInput = keyboard_check_pressed(ord("P"))
	
	HandleMovementX(slideSpeed*facing)
	CheckIfWalkOffEdge()
	slideTimer--;
	
	if place_meeting(x, y-9, tileMapID) {
		if horizontalInput != 0 { facing = horizontalInput }
	} else {
		if jumpInput {
			enterAirState()
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

state = airState