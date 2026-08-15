x = 0; y = 0
cameraX = 0; cameraY = 0
	
view_width = 240;
view_height = 180;
window_scale = 6;

window_set_size(view_width*window_scale, view_height*window_scale);
alarm[0] = 1;

surface_resize(application_surface, view_width*window_scale, view_height*window_scale);
//surface_resize(application_surface, view_width, view_height);