function Polygon(_x, _y, _verts, _sprite, _index) constructor 
{
	#macro FOR_VERTS for (var _i = 0; _i < Size; _i++)
	#macro NEXT_VERT Verts.[(_i+1) mod Size]
	
	var _size = array_length(_verts);
	X      = _x;
	Y      = _y;
	Verts  = _verts;
	U      = array_create(_size);
	V      = array_create(_size);
	Off    = array_create(_size);
	Rot    = 0;
	COS    = cos(0);
	SIN    = sin(0);
	ScaleX = 1;
	ScaleY = 1;
	Size   = _size;
	Tex    = sprite_get_texture(_sprite, _index);
	TexW   = sprite_get_width(_sprite);
	TexH   = sprite_get_height(_sprite);

	FOR_VERTS 
	{
		with Verts[_i] 
		{
			var _offX = X - _x; // + 0.5 to align with built-in sprites 
			var _offY = Y - _y; // + 0.5 to align with built-in sprites 
		}
		Off[_i] = new Vec2(_offX, _offY);	
		U[_i] = _offX/TexW;
		V[_i] = _offY/TexH;
	}
		
	function Update() 
	{
		var _sX = ScaleX;
		var _sY = ScaleY;
		
		FOR_VERTS 
		{
			var _x = Off[_i].X * _sX;
			var _y = Off[_i].Y * _sY;
			U[_i] = _x/TexW;
			V[_i] = _y/TexH;
			Verts[_i].X = X + ((_x * COS) - (_y * SIN));
			Verts[_i].Y = Y + ((_x * SIN) + (_y * COS));
		}
	}
	
	function Move(_x, _y) 
	{
		X += _x;
		Y += _y;
		Update();
	}
	
	function SetPosition(_x, _y) 
	{
		X = _x;
		Y = _y;
		Update();
	}
	
	function SetRotation(_angle) 
	{
		Rot = _angle;
		_angle = -_angle * RADIAN;
		COS = cos(_angle);
		SIN = sin(_angle);
	}
	
	function SetScale(_scaleX, _scaleY) 
	{
		ScaleX = _scaleX;
		ScaleY = _scaleY;
	}
			
	function Draw(_w, _c) 
	{
		FOR_VERTS
		{
			var _s = Verts[_i];
			var _e = Verts[(_i+1) mod Size];
			draw_line_width_color(_s.X, _s.Y, _e.X, _e.Y, _w, _c, _c);
		}
	}
	
	function DrawDebug()
	{
		FOR_VERTS
		{
			var _s = Verts[_i];
			var _e = Verts[(_i+1) mod Size];
			draw_line_width_color(_s.X, _s.Y, _e.X, _e.Y, 2, c_white, c_white);
		}
		draw_circle(X, Y, 1, false);
		draw_line(X, Y, X + COS*100, Y + SIN*100);
	}
	
	function AssignSprite(_sprite, _index)
	{
		Tex    = sprite_get_texture(_sprite, _index);
		TexW   = sprite_get_width(_sprite);
		TexH   = sprite_get_height(_sprite);
		Update();
	}
	
	function DrawTexturedRect()
	{  
		draw_primitive_begin_texture(pr_trianglestrip, Tex);
		draw_vertex_texture(Verts[0].X,  Verts[0].Y, 0,      0);
		draw_vertex_texture(Verts[1].X,  Verts[1].Y, ScaleX, 0);
		draw_vertex_texture(Verts[3].X,  Verts[3].Y, 0,      ScaleY);
		draw_vertex_texture(Verts[2].X,  Verts[2].Y, ScaleX, ScaleY);
		draw_primitive_end();		
	}
	
	function DrawTextured()
	{  
		draw_primitive_begin_texture(pr_trianglestrip, Tex);
		draw_vertex_texture(Verts[0].X, Verts[0].Y, U[0], V[0]);
		var _size = (Size div 2) + 1;
		var _last = Size - 1;
		for (var _i = 1; _i < _size; _i++) 
		{
			draw_vertex_texture(Verts[_i].X,    Verts[_i].Y,    U[_i],    V[_i]);
			draw_vertex_texture(Verts[_last].X, Verts[_last].Y, U[_last], V[_last]);
			_last--;
		}
		if !(Size & 1)
		{
			_last = Size - 1;
			draw_vertex_texture(Verts[_last].X, Verts[_last].Y, U[_last], V[_last]);
		}
		draw_primitive_end();		
	}
			
	function Copy() 
	{
		var _v = array_create(Size);
		var _p;
		FOR_VERTS 
		{
			_p = Verts[_i];
			_v[_i] = new Vec2(_p.X, _p.Y);
		}
		return new Polygon(X, Y, _v);
	}
}

function PolygonCreateTri(_x1, _y1, _x2, _y2, _x3, _y3, _sprite) 
{
	var _originX = (_x1 + _x2 + _x3)/3 +1;
	var _originY = (_y1 + _y2 + _y3)/3 +1;
		
	var _verts = [new Vec2(_x1, _y1), new Vec2(_x2, _y2), new Vec2(_x3, _y3)];
	return new Polygon(_originX, _originY, _verts, _sprite, 0);
}

function PolygonCreateEQTri(_x1, _y1, _x2, _y2, _sprite) 
{
	#macro EQTRI_HEIGHT_COEFFICIENT (sqrt(3)*0.5)
	#macro EQTRI_DTAN_30            (dtan(30))
	
	// Midpoint between vOne and vTwo
	var _mX = (_x1 + _x2)/2;
	var _mY = (_y1 + _y2)/2;
		
	// Normal of line segment normalized
	var _vX = -(_y2 - _y1);
	var _vY =  (_x2 - _x1);
	var _d  = sqrt((_vX*_vX)+(_vY*_vY));
	_vX /= _d;
	_vY /= _d;
		
	// Height of equilateral triangle 
	var _edgeLength = sqrt(sqr(_x2-_x1)+sqr(_y2-_y1));
	var _height     = _edgeLength * EQTRI_HEIGHT_COEFFICIENT;
		
	// Third vertex of triangle
	var _x3 = _mX + (_vX * _height); 
	var _y3 = _mY + (_vY * _height);
		
	// Origin coordinates
	var _opposite = EQTRI_DTAN_30 * (_edgeLength/2);
	var _originX = _mX + (_vX * _opposite);
	var _originY = _mY + (_vY * _opposite);
		
	var _verts = [new Vec2(_x1, _y1), new Vec2(_x2, _y2), new Vec2(_x3, _y3)];
	return new Polygon(_originX, _originY, _verts, _sprite, 0);
}
	
function PolygonCreateRect(_x, _y, _w, _h, _sprite) 
{	
	var _verts = [new Vec2(_x, _y), new Vec2(_x+_w, _y), new Vec2(_x+_w, _y+_h), new Vec2(_x, _y+_h)];
	return new Polygon(_x+(_w/2)+1, _y+(_h/2)+1, _verts, _sprite, 0);
}

function PolygonCreateFromBBOX(_sprite) 
{	
	var _left   = sprite_get_bbox_left(_sprite)   - sprite_get_xoffset(_sprite);
	var _right  = sprite_get_bbox_right(_sprite)  - sprite_get_xoffset(_sprite) + 1;
	var _bottom = sprite_get_bbox_bottom(_sprite) - sprite_get_yoffset(_sprite) + 1;
	var _top    = sprite_get_bbox_top(_sprite)    - sprite_get_yoffset(_sprite);
	
	var _verts = 
	[
		new Vec2(_left,  _top), 
		new Vec2(_right, _top), 
		new Vec2(_right, _bottom), 
		new Vec2(_left,  _bottom)
	];
	return new Polygon(0, 0, _verts, _sprite, 0);
}