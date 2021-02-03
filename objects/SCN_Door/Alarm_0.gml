image_angle += Swing;
if (abs(image_angle - Start) < MaxOpen) alarm[0] = 1;

Collider.SetRotation(image_angle);
Collider.Update();

