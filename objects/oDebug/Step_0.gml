if keyboard_check_pressed(vk_return) { isDebug = !isDebug }
if !isDebug { exit; }

if keyboard_check_pressed(ord("R")) {
	room_restart()
}