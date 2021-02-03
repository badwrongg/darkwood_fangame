function CollisionCircle(_r, _object)
{
	var _poly = _object.Collider;
	var _collided = false;
	var _size = _poly.Size;

	for (var _q = 0; _q < _size; _q++) 
	{
		with _poly
		{
			var _sx = Verts[_q].X;
			var _sy = Verts[_q].Y;
			var _ex = Verts[(_q+1) mod _size].X;
			var _ey = Verts[(_q+1) mod _size].Y;
		}
		
		var _vx = (_ex - _sx);
		var _vy = (_ey - _sy);
		var _dot = (_vx*_vx) + (_vy*_vy);
		var _lineX = x - _sx;
		var _lineY = y - _sy;
		var _n  = max(0, min(_dot, ((_vx * _lineX) + (_vy * _lineY)))) / _dot;
		var _cX = _sx + (_n * _vx);
		var _cY = _sy + (_n * _vy);
		_vx = x - _cX;
		_vy = y - _cY;
		var _dist = sqrt((_vx*_vx)+(_vy*_vy))
		if (_dist < _r) 
		{
			_vx /= _dist;
			_vy /= _dist;
			x = _cX + (_vx*_r);
			y = _cY + (_vy*_r);
			_collided = true;
			if (_object.object_index == SCN_Box) _object.PushBox(x, y);
		}
	}
	return _collided;
}


function CollisionSAT(_r2, _r1) 
{
	var _poly1 = _r1;
	var _poly2 = _r2;
		
	for (var _check = 0; _check < 2; _check++) 
	{
		if (_check == 1) 
		{
			_poly1 = _r2;
			_poly2 = _r1;
		}
		
		for (var _a = 0; _a < _poly1.Size; _a++) 
		{
			var _q = 0;
			var _b = (_a + 1) mod _poly1.Size;
			var _axisProjX = -(_poly1.Verts[_b].Y - _poly1.Verts[_a].Y);
			var _axisProjY =  (_poly1.Verts[_b].X - _poly1.Verts[_a].X);
			var _d = sqrt((_axisProjX * _axisProjX) + (_axisProjY * _axisProjY));
			_axisProjX = _axisProjX / _d;
			_axisProjY = _axisProjY / _d;

			var _minR1 = infinity, var _maxR1 = -infinity;
			for (var _p = 0; _p < _poly1.Size; _p++) 
			{
				_q = (_poly1.Verts[_p].X * _axisProjX + _poly1.Verts[_p].Y * _axisProjY);
				_minR1 = min(_minR1, _q);
				_maxR1 = max(_maxR1, _q);
			}

			var _minR2 = infinity, _maxR2 = -infinity;
			for (var _p = 0; _p < _poly2.Size; _p++) 
			{
				_q = (_poly2.Verts[_p].X * _axisProjX + _poly2.Verts[_p].Y * _axisProjY);
				_minR2 = min(_minR2, _q);
				_maxR2 = max(_maxR2, _q);
			}

			if (!(_maxR2 >= _minR1 && _maxR1 >= _minR2)) return false;
		}
	}	
	return true;
}

function CollisionStaticSAT(_r2, _r1) 
{
	var _poly1 = _r1;
	var _poly2 = _r2;
	var _overlap = infinity;
		
	for (var _check = 0; _check < 2; _check++) 
	{
		if (_check == 1) 
		{
			_poly1 = _r2;
			_poly2 = _r1;
		}
		
		for (var _a = 0; _a < _poly1.Size; _a++) 
		{
			var _q = 0;
			var _b = (_a + 1) mod _poly1.Size;
			var _axisProjX = -(_poly1.Verts[_b].Y - _poly1.Verts[_a].Y);
			var _axisProjY =  (_poly1.Verts[_b].X - _poly1.Verts[_a].X);
			var _d = sqrt((_axisProjX * _axisProjX) + (_axisProjY * _axisProjY));
			_axisProjX = _axisProjX / _d;
			_axisProjY = _axisProjY / _d;

			var _minR1 = infinity, var _maxR1 = -infinity;
			for (var _p = 0; _p < _poly1.Size; _p++) 
			{
				_q = (_poly1.Verts[_p].X * _axisProjX + _poly1.Verts[_p].Y * _axisProjY);
				_minR1 = min(_minR1, _q);
				_maxR1 = max(_maxR1, _q);
			}

			var _minR2 = infinity, _maxR2 = -infinity;
			for (var _p = 0; _p < _poly2.Size; _p++) 
			{
				_q = (_poly2.Verts[_p].X * _axisProjX + _poly2.Verts[_p].Y * _axisProjY);
				_minR2 = min(_minR2, _q);
				_maxR2 = max(_maxR2, _q);
			}

			_overlap = min(min(_maxR1, _maxR2) - max(_minR1, _minR2), _overlap);
			if (!(_maxR2 >= _minR1 && _maxR1 >= _minR2)) return false;
		}
	}	
	var _vx = _r1.X - _r2.X; 
	var _vy = _r1.Y - _r2.Y;
	var _d = sqrt((_vx*_vx) + (_vy*_vy));
	x -= _overlap * (_vx / _d);
	y -= _overlap * (_vy / _d);
	return true;
}

function CollisionStaticDIAGS(_this, _other) 
{	
	var _poly1 = _this.Collider;
	var _poly2 = _other.Collider;
	var _dir   = -1;
	
	for (var _check = 0; _check < 2; _check++) 
	{
		
		if (_check == 1) 
		{
			_poly1 = _other.Collider;
			_poly2 = _this.Collider;
			_dir   = 1;
		}
		
		for (var _p = 0; _p < _poly1.Size; _p++)
		{
			var _r1sX = _poly1.X;
			var _r1sY = _poly1.Y;
			var _r1eX = _poly1.Verts[_p].X;
			var _r1eY = _poly1.Verts[_p].Y;
			
			var _dx = 0;
			var _dy = 0;
		
			for (var _q = 0; _q < _poly2.Size; _q++) 
			{
				var _r2s = _poly2.Verts[_q];
				var _r2e = _poly2.Verts[(_q+1) mod _poly2.Size];
				
				var _xDiff1 = _r1sX  - _r2s.X;
				var _yDiff1 = _r1sY  - _r2s.Y;
				var _xDiff2 = _r2e.X - _r2s.X;
				var _yDiff2 = _r1sY  - _r1eY;
				var _xDiff3 = _r1eX  - _r1sX;
				var _yDiff3 = _r2e.Y - _r2s.Y;
				
				var _h =    _xDiff2 * _yDiff2 + _xDiff3 * _yDiff3;
				var _t1 = (-_yDiff3 * _xDiff1 + _xDiff2 * _yDiff1) / _h;
				var _t2 = ( _yDiff2 * _xDiff1 + _xDiff3 * _yDiff1) / _h;

				if (_t1 >= 0 && _t1 < 1 && _t2 >= 0 && _t2 < 1) 
				{
					if (_other.object_index == SCN_Box) _other.PushBox(x, y);
					_dx += (1 - _t1) * (_r1eX - _r1sX);
					_dy += (1 - _t1) * (_r1eY - _r1sY);
				}
			}
			x += _dx * _dir;
			y += _dy * _dir;
			_this.Collider.SetPosition(x, y);
		}
	}
}