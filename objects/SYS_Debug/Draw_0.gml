if !DebugOn exit;
	
if DrawCollision
{
	with COL_Collision Collider.Draw(2, c_yellow);
	with CHR_Character draw_circle_color(x, y, CollisionRadius, c_yellow, c_yellow, true);	
	with SCN_Box draw_text(x, y, "Mass: "+string(Mass));
}