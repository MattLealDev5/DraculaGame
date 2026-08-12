if keyboard_check_pressed(vk_return) {
	isDebug = !isDebug
	with oCamera {
		//if isDebug
		//	surface_resize(application_surface, view_width*window_scale, view_height*window_scale);
		//else
		//	surface_resize(application_surface, view_width, view_height);
	}
}
if !isDebug { exit; }

if keyboard_check_pressed(ord("R")) {
	room_restart()
}