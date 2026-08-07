sprite = sPlayer

walkSpeed = 1
currWalkSpeed = 0

slideSpeed = 2
slideTimer = 0
slideTimerSet = 15

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
	
	currGravity -= 0.1
	currWalkSpeed = horizontalInput * walkSpeed
	
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
	
	if jumpInput {
		enterAirState()
	}
	
	HandleMovementX(slideSpeed)
	CheckIfWalkOffEdge()
	
	slideTimer--;
	if slideTimer <= 0 || place_meeting(x+1, y, tileMapID) {
		enterGroundState()
	}
}
#endregion

state = airState