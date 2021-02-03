function light_trace_polygon(_shadowCaster, _light) {

	// Get the shadow caster attributes
	var _collider = _shadowCaster.Collider;
	var _size = _collider.Size;
	var sc_shadow_length = _shadowCaster.shadow_length;

	// Get the light's attributes
	var light_x = _light[| eLight.X];
	var light_y = _light[| eLight.Y];
	var light_range = _light[| eLight.Range];
	var light_type = _light[| eLight.Type];
	var light_direction = _light[| eLight.Direction];
	var shadow_length = min(sc_shadow_length, _light[| eLight.ShadowLength]);
	var line_emitter = light_type == eLightType.Area || light_type == eLightType.Line;

	// Get the vertex array
	var face_vertices = 6 * _size;
	var shadow_index = 0;
	var shadow_array = global.lightVertexArrayMap[? face_vertices];
	if(shadow_array == undefined) {
		// Initialise the array of this size
		shadow_array = array_create(face_vertices);
		global.lightVertexArrayMap[? face_vertices] = shadow_array;
	}

	if(line_emitter) {
		// Precompute variables for the area or line light to use per-vertex
		var _dir = light_direction + 90;
		var _w = _light[| eLight.Width] * 0.5; // * 0.5 because the line emitter is centered on the light
		var _c = cos(_dir * pi / 180) * _w;
		var _s = -sin(_dir * pi / 180) * _w;
		var areaPoint1 = [light_x - _c, light_y - _s];
		var areaPoint2 = [light_x + _c, light_y + _s];
		var p1p2 = [areaPoint2[0] - areaPoint1[0], areaPoint2[1] - areaPoint1[1]];
		var p1p2_dot = dot_product(p1p2[0], p1p2[1], p1p2[0], p1p2[1]);
	}

	// For each vertex in the polygon, trace a line from the light
	var v1, v2;
	var _verts = _collider.Verts;
	for (var i = 0; i < _size; i++) {
		var vx = _verts[i].X; 
		var vy = _verts[i].Y;
		var langle = light_direction;
	
		if(line_emitter) {
			// Either the vertex is perpendicular to the line emitter,
			// or we take the angle to whichever vertex on the line this polygon vertex is closest to
			var p1v = [vx - areaPoint1[0], vy - areaPoint1[1]];
			var projection = dot_product(p1v[0], p1v[1], p1p2[0], p1p2[1]) / p1p2_dot;
			if(projection < 0.0) langle = point_direction(areaPoint1[0], areaPoint1[1], vx, vy);		
			else if(projection > 1.0) langle = point_direction(areaPoint2[0], areaPoint2[1], vx, vy);	
			else {
				// Perpendicular
				var __x = areaPoint1[0] + p1p2[0] * projection;
				var __y = areaPoint1[1] + p1p2[1] * projection;
				langle = point_direction(__x, __y, vx, vy);
			}
		}
		else if(light_type != eLightType.Directional) {
			// Angle from light to vertex
			langle = point_direction(light_x, light_y, vx, vy);
		}
	
		if(i == 0) {
			// Set first line
			v1 = [vx, vy];
			v2 = [vx + lengthdir_x(shadow_length, langle), vy + lengthdir_y(shadow_length, langle)];
		}
		else {
			// Second line
			var v3 = [vx, vy];
			var v4 = [vx + lengthdir_x(shadow_length, langle), vy + lengthdir_y(shadow_length, langle)];
		
			// Create a triangle between v1,v2,v3
			shadow_array[@ shadow_index++] = v1;
			shadow_array[@ shadow_index++] = v2;
			shadow_array[@ shadow_index++] = v3;
	
			// Create a triangle between v3,v4,v2
			shadow_array[@ shadow_index++] = v3;
			shadow_array[@ shadow_index++] = v4;
			shadow_array[@ shadow_index++] = v2;
		
			// Start next line where this ended
			v1 = v3;
			v2 = v4;
		}
	}


	// Create a triangle between v1,v2,v3
	shadow_array[@ shadow_index++] = v1;
	shadow_array[@ shadow_index++] = v2;
	shadow_array[@ shadow_index++] = shadow_array[0];
	// Create a triangle between v3,v4,v2
	shadow_array[@ shadow_index++] = shadow_array[0];
	shadow_array[@ shadow_index++] = shadow_array[1];
	shadow_array[@ shadow_index++] = v2;

	return shadow_array;
}
