function CharacterMove(_moveX, _moveY)
{
	x += _moveX;
	y += _moveY;
		
	var _collided = false;
	var _collidedList = ds_list_create();
	var _count = instance_place_list(x, y, COL_Collision, _collidedList, false);	
	if (_count == 0) return false;
	
	for (var _i = 0; _i < _count; _i++)
		_collided = CollisionCircle(CollisionRadius, _collidedList[| _i]);
	
	ds_list_destroy(_collidedList);
	return _collided;
}

function CharacterMovementComponent2D(_speedMax, _accel) constructor
{
	X          = 0;
	Y          = 0;
	Mode       = MOVE_GROUND;
	Input      = new Vec2(0, 0);
	Impulse    = new Vec2(0, 0);

	Speed      = 0;
	SpeedMax   = _speedMax;
	Accel      = _accel;
	Modifier   = 1;
	
	InputReceived   = false;
	ImpulseRecieved = false;
		
	function RecieveInput(_x, _y) {
		if (_x != 0 || _y != 0)
		{
			Input.X = _x; 
			Input.Y = _y; 
			Input.Normalize();
			InputReceived = true;
			return;
		}
		with Input { X = 0; Y = 0; }
		InputReceived = false;
	}
		
	function RecieveImpulse(_dir, _power) 
	{
		_dir.SetMagnitude(_power);
		Impulse.Add(_dir);
		ImpulseRecieved = true;
	}
	
	function RecieveImpulseNormalized(_vx, _vy)
	{
		with Impulse { X += _vx; Y += _vy; }
		ImpulseRecieved = true;
	}
								
	function StopImmediately() 
	{
		Speed = 0;
		X = 0;
		Y = 0;
		Input.Set(0, 0);
		InputReceived = false;
		Impulse.Set(0, 0);
		ImpulseRecieved = false;
	}
		
	function Update(_tick) 
	{
		Speed = (InputReceived ? min(Speed + Accel, SpeedMax) : 0) * Modifier;
		SpeedReal = Speed * _tick;
		Modifier = 1;
		X = clamp((Input.X * SpeedReal) + Impulse.X, -TERMINAL_V, TERMINAL_V);
		Y = clamp((Input.Y * SpeedReal) + Impulse.Y, -TERMINAL_V, TERMINAL_V);
		
		if ImpulseRecieved 
		{
			var _drag = (Mass + (Speed * COF_DRAG)) * _tick;
			with Impulse 
			{
				var _dist = sqrt((X*X)+(Y*Y));
				if (_dist > _drag)
				{
					X -= (X/_dist) * _drag;
					Y -= (Y/_dist) * _drag;
					return;
				}
				X = 0;
				Y = 0;
			}
		}
		ImpulseRecieved = false;
	}
}

function CharacterGunComponent(_xOffset, _yOffset, _aimAngle, _fireRate, _layer) constructor
{
	X        = _xOffset;
	Y        = _yOffset;
	XOffset  = _xOffset;
	YOffset  = _yOffset;
	AAOffset = _aimAngle;
	Ammo     = ACT_Laser;
	CDTimer  = 0;
	FireRate = _fireRate;
	Angle    = 0;
	AimAngle = 0;
	COS      = 0;
	SIN      = 0;
	AimCOS   = 0;
	AimSIN   = 0;
	Layer    = _layer
	Sprite   = sGunDebug;
	
	function SetPosition(_x, _y, _angle)
	{
		Angle    = _angle;
		AimAngle = _angle + AAOffset;
		
		_angle = -_angle * RADIAN;
		COS    = cos(_angle);
		SIN    = sin(_angle);
		
		_angle = - AimAngle * RADIAN;
		AimCOS = cos(_angle);
		AimSIN = sin(_angle);
		X = _x + ((XOffset * COS) - (YOffset * SIN));
		Y = _y + ((XOffset * SIN) + (YOffset * COS));	
	}
	
	function Fire(_target, _vx, _vy)
	{
		if (CDTimer > 0) return;
		CDTimer = FireRate;
		var _angle = AimAngle, _cos = AimCOS, _sin = AimSIN;
		with instance_create_layer(X, Y, Layer, Ammo)
		{
			image_angle = _angle;
			VX = _cos;
			VY = _sin;
			Target = _target;
			EVX = _vx;
			EVY = _vy;
		}
	}
	
	function Cooldown(_tick)
	{
		CDTimer = max(CDTimer - _tick, 0);
	}
	
	function ChangeAmmo(_ammo)
	{
		Ammo = _ammo;	
	}
	
	function SetFirerate(_fireRate)
	{
		FireRate = _fireRate;	
	}
	
	function ChangeGunSprite(_sprite)
	{
		Sprite = _sprite;	
	}
	
	function DrawGunSprite()
	{
		draw_sprite_ext(Sprite, 0, X ,Y, 1, 1, AimAngle, c_white, 1);	
	}
	
	function DrawDebugOrigin()
	{
		draw_circle(X, Y, 4, false);	
	}
}