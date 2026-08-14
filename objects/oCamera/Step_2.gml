#macro view view_camera[0]
camera_set_view_size(view, view_width, view_height)

if player != noone {
	cameraX = player.x-view_width/2; cameraX = clamp(cameraX, 0, room_width-view_width)
	cameraY = 0;
	
	camera_set_view_pos(view, cameraX, cameraY)
}