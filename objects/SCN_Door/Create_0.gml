event_inherited();

InstanceCreateSwitch(id, "Door", "Open");

Start = image_angle;
Swing = 0;
Speed = 4;
Open  = false;

function Activate()
{
	if Open
	{
		Swing = sign(angle_difference(Start, image_angle)) * Speed;
		Open = false;
		alarm[0] = 0;
		alarm[1] = 1;
		return;
	}	
	
	var _dir = point_direction(x, y, CHR_Player.x, CHR_Player.y);
	Swing = sign(angle_difference(image_angle, _dir)) * Speed * sign(image_xscale);
	Open = true;
	alarm[0] = 1;
	alarm[1] = 0;
}