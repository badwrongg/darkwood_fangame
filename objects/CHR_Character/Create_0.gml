event_inherited();
Velocity = new CharacterMovementComponent2D(CharacterSpeed, CharacterAccel);
CollisionRadius = sprite_get_width(mask_index)/2;
AvoidRadius = ceil(SpriteGetDiag(mask_index)/2);