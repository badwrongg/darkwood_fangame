event_inherited();

LightLastIntensity = Light_Intensity;

function SetLocation(_x, _y, _angle)
{
	light[| eLight.X] = _x;
	light[| eLight.Y] = _y;	
	light[| eLight.Direction] = _angle;
}

function ToggleLight()
{
	if (light[| eLight.Intensity] == 0)
		light[| eLight.Intensity] = LightLastIntensity;
	else light[| eLight.Intensity] = 0;
}