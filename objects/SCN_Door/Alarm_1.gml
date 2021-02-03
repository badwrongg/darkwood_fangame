if (abs(image_angle - Start) > abs(Swing))
{
	image_angle += Swing;
	alarm[1] = 1;
} 
else image_angle = Start;	


Collider.SetRotation(image_angle);
Collider.Update();