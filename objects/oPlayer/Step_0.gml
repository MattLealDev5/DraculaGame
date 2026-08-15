//var horizontalInput = keyboard_check(ord("D")) - keyboard_check(ord("A"))
//var jumpInput = keyboard_check_pressed(vk_space)

//if horizontalInput != 0 show_debug_message("move")
//if jumpInput show_debug_message("jump")



state()

if hurtInvincibility <= 0 {
	var enemy = instance_place(x, y, oEnemy)
	if enemy != noone {
		enterHurtState()
	}
} else { hurtInvincibility-- }