sprite = sPlayer

walkSpeed = 1
currWalkSpeed = 0

slideSpeed = 2

jumpForce = 3
currGravity = 0
grounded = false

tileMapID = layer_tilemap_get_id("Blocks");


#region Grounded State
enterGroundState = function() {
	grounded = true
	currGravity = 0
	state = groundState
}
groundState = function() {
	var horizontalInput = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	var jumpInput = keyboard_check_pressed(vk_space)
	
	currWalkSpeed = horizontalInput * walkSpeed
	if jumpInput {
		enterAirState()
	}
	
	HandleMovementX(currWalkSpeed)
	CheckIfWalkOffEdge()
}
#endregion

#region Airbourne State
enterAirState = function() {
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
	currWalkSpeed = 0
	state = slideState
}
slideState = function() {
	var horizontalInput = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	var jumpInput = keyboard_check_pressed(vk_space)
	
	if jumpInput {
		currGravity = jumpForce;
		grounded = false
		state = airState
	}
	
	HandleMovementX(slideSpeed)
	CheckIfWalkOffEdge()
}
#endregion

state = airState