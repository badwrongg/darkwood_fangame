function Animation(_sprite) constructor
{
	Sprite = _sprite;
	Index  = 0;
	FPS    = sprite_get_speed(_sprite) * MICRO_SEC;
	Speed  = 1;
	Frames = sprite_get_number(_sprite);
	
	XScale = 1;
	YScale = 1;
	Rot    = 0;
	Alpha  = 1;
	
	function Update()
	{	
		Index = Loop(Loop, (FPS * delta_time * Speed), Frames);
		return abs(Index);
	}
	
	function SetSprite(_sprite)
	{
		Sprite = _sprite;
		FPS    = sprite_get_speed(_sprite) * MICRO_SEC;
		Frames = sprite_get_number(_sprite);
		Index  = Index mod Frames;
	}
	
	// Setters
	function SetSpeed(_speed)   { Speed  = _speed; }
	function SetIndex(_index)   { Index  = _index*sign(Speed); }
	function SetXScale(_xscale) { XScale = _xscale; }
	function SetYScale(_yscale) { YScale = _yscale; }
	function SetAngle(_angle)   { Rot    = max(_angle, _angle + 360); }
	function SetAlpha(_alpha)   { Alpha  = _alpha; }
	function SetScale(_xscale, _yscale) { XScale = _xscale; YScale = _yscale; }
	
	// Getters
	function GetSpeed()  { return Speed; }
	function GetFrames() { return Frames; }
	function GetIndex()  { return abs(Index); }
	function GetXScale() { return XScale; }
	function GetYScale() { return YScale; }
	function GetAngle()  { return Rot; }
	function GetAlpha()  { return Alpha; }
	function GetSprite() { return Sprite; }

	function Draw(_x, _y)
	{
		draw_sprite(Sprite, Index, _x, _y);
	}
	
	function DrawExt(_x, _y, _col)
	{ 
		draw_sprite_ext(Sprite, Index, _x, _y, XScale, YScale, Rot, _col, Alpha);	
	}
}

function AnimationIndex(_sprite) constructor
{
	Sprite = _sprite;
	Index  = 0;
	FPS    = sprite_get_speed(_sprite) * MICRO_SEC;
	Speed  = 1;
	Frames = sprite_get_number(_sprite);
	
	function Update()
	{
		Index = Loop(Loop, (FPS * delta_time * Speed), Frames);	
		return abs(Index);
	}
	
	function SetSprite(_sprite)
	{
		Sprite = _sprite;
		FPS    = sprite_get_speed(_sprite) * MICRO_SEC;
		Frames = sprite_get_number(_sprite);
		Index  = Index mod Frames;
	}
	
	// Setters
	function SetSpeed(_speed) { Speed  = _speed; }
	function SetIndex(_index) { Index  = _index*sign(Speed); }
	
	// Getters
	function GetSpeed()  { return Speed; }
	function GetIndex()  { return abs(Index); }
	function GetSprite() { return Sprite; }
	function GetFrames() { return Frames; }
}