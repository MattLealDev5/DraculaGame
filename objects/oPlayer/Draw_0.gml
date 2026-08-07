draw_sprite(sprite, 0, x, y)
draw_line_colour(0, y, room_width, y, c_aqua, c_aqua)
draw_text_color(x, y, $"{place_meeting(x, y+1, tileMapID)}", c_aqua, c_aqua, c_aqua, c_aqua, 1)