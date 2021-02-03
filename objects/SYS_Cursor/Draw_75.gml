if instance_exists(Tooltip) Tooltip.Draw(GUIX, GUIY);
else draw_sprite(sprite_index, image_index, GUIX, GUIY);
image_index = 0;
Tooltip = noone;