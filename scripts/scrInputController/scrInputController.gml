function InputController() constructor {
	left = ord("D")
	right = ord("A")
	down = ord("S")
	a = ord("P")
	b = ord("L")
		
	walkDir = function() { return keyboard_check(left) - keyboard_check(right) }
	jump = function() { return keyboard_check_pressed(a) }
	jumpRelease = function() { return keyboard_check_released(a) }
	slide = function() { return keyboard_check(down) }
	shoot = function() { return keyboard_check_pressed(b) }
}