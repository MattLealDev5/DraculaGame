walkSpeed = 1
currWalkSpeed = 0

jumpForce = 3
currGravity = 0
grounded = false


groundState = function() {
	var horizontalInput = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	var jumpInput = keyboard_check_pressed(vk_space)
	
	currWalkSpeed = horizontalInput * walkSpeed
	if jumpInput {
		currGravity = jumpForce; grounded = false
		state = airState
	}
	
	HandleMovementX(currWalkSpeed)
	CheckIfWalkOffEdge()
}
airState = function() {
	var horizontalInput = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	
	currGravity -= 0.1
	currWalkSpeed = horizontalInput * walkSpeed
	
	HandleMovementX(currWalkSpeed)
	HandleMovementY(currGravity)
}

state = airState