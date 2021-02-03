function VectorAngle(_vx, _vy)
{
	var _angle = -arctan2(_vy, _vx) * PIRADIAN;
	if (_angle < 0) _angle += 360;	
	return _angle;
}

function LineSegment(_x1, _y1, _x2, _y2) constructor
{
	var _vx = _x2 - _x1;
	var _vy = _y2 - _y1;
		
	Start = new Vec2(_x1, _y1);
	End   = new Vec2(_x2, _y2);
	Mid   = new Vec2((_x1 + _x2)/2, (_y1 + _y2/2));
	Dir   = VectorAngle(_vx, _vy);
	Dist  = sqrt((_vx*_vx)+(_vy*_vy));
	
	function FullyOverlapsCircle(_x, _y, _r)
	{
		return (point_distance(Start.X, Start.Y, _x, _y) > _r && point_distance(End.X, End.Y, _x, _y) > _r);
	}
	
	function Draw(_w, _c)
	{
		draw_line_width_color(Start.X, Start.Y, End.X, End.Y, _w, _c, _c);	
	}
}

function LineSegmentFromObject()
{
	var _w = sprite_get_width(sprite_index) * image_xscale;
	image_angle = Range(image_angle, 360); 
	var _dir = -image_angle * RADIAN;
	var _endX = x + cos(_dir) * _w;
	var _endY = y + sin(_dir) * _w;
	return new LineSegment(x, y, _endX, _endY);	
}