#macro view view_camera[0]
camera_set_view_size(view, view_width, view_height)

if player != noone {
	var xPos = player.x-view_width/2;
	
	xPos = clamp(xPos, 0, room_width-view_width)
	var yPos = 0;
	
	camera_set_view_pos(view, xPos, yPos)
}