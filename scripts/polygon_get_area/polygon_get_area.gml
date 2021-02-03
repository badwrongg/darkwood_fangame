function polygon_get_area(_polygon) {
	var _verts = _polygon.Verts;
	var _size = _polygon.Size;
	var area = [1000000000, 1000000000, -1000000000, -1000000000];

	for(var i = 0; i < _size; ++i) {

		var px = _verts[i].X 
		if(px < area[0]) area[0] = px;
		else if(px > area[2]) area[2] = px;
	
		var py = _verts[i].Y;
		if(py < area[1]) area[1] = py;
		else if(py > area[3]) area[3] = py;
	}
	return area;
}
