if !DebugOn exit;

draw_set_font(FNT_Debug);
draw_set_halign(fa_right);

TX display_get_gui_width() - 20;
TY 40;

TEXT "View W: "+string(camera_get_view_width(VIEW)) ENDLINE
TEXT "View H: "+string(camera_get_view_height(VIEW)) ENDLINE
NEWLINE
TEXT "FPS Avg: "+string(FPSLow) ENDLINE
NEWLINE
TEXT "Collision - F5" ENDLINE
TEXT "Zoom - Mouse Wheel" ENDLINE
TEXT "Flashlight - F" ENDLINE
TEXT "Film Grain: "+string(global.FilmGrainStrength)+" - Up/Down" ENDLINE

with CHR_Player
{
	TEXT "Speed PPS: "+string_format(round(Velocity.Speed), 5, 0) ENDLINE
}