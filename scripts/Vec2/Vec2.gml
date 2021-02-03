function Vec2(_x, _y) constructor 
{
	X = _x;
	Y = _y;
	
	function Add(_other) 
	{
		X += _other.X;
		Y += _other.Y;
	}
	function Subtract(_other) 
	{
		X -= _other.X;
		Y -= _other.Y;
	}
	
	function Set(_x, _y) 
	{
		X = _x;
		Y = _y;
	}
	
	function Angle() 
	{
		var _angle = -arctan2(Y, X) * PIRADIAN;
		if (_angle < 0) _angle += 360;
		return _angle;
	}
	
	function SetMagnitude(_magnitude) 
	{
		Normalize();
		X *= _magnitude;
		Y *= _magnitude;
	}
	
	function Normalize() 
	{
		var _dir = arctan2(Y, X);
		X = cos(_dir);
		Y = sin(_dir);
	}
}

function Vec2SafeNormalized(_x, _y) 
{
	var _dir = -arctan2(_y, _x);
	return new Vec2(cos(_dir), sin(_dir));
}


function Vec2Lerp() constructor 
{
	// Stores position, start and end vectors, plus functions to lerp between them
	Pos      = new Vec2(0, 0); // The main vector result from lerp
	Start    = new Vec2(0, 0); 
	End      = new Vec2(0, 0);
	LerpPos  = 0;
	LerpSpd  = 0;
	
	// Set vectors, speed and position
	function LerpStart(_sX, _sY, _eX, _eY, _spd) 
	{
		Start.X = _sX;
		Start.Y = _sY;
		End.X   = _eX;
		End.Y   = _eY;
		LerpPos = 0;
		LerpSpd = _spd;
	}
	
	// Lerp from start to end
	function LerpStep() 
	{
		LerpPos += LerpSpd * TICK;
		if (LerpPos < 1) 
		{
			// Lerp is not done
			Pos.X = lerp(Start.X, End.X, LerpPos);
			Pos.Y = lerp(Start.Y, End.Y, LerpPos);
			return false;
		}
		else 
		{
			// Lerp is done
			LerpPos = 1;
			Pos.X = End.X;
			Pos.Y = End.Y;
			return true;
		}
	}
	
	// Used if another value needs to follow the same lerp
	function LerpOther(_val1, _val2) 
	{
		return lerp(_val1, _val2, LerpPos);	
	}
}