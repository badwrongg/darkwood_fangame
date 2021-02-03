/// @desc Create a polygon from a set of points
/// @arg set The set of points, each point being a 1D array of type eVertex
/// @returns Returns the polygon array
function polygon_create(argument0) {

	var set = argument0;

	// Get the length of the 1-dimensional array
	var length = array_length(set);

	// Create the polygon
	var polygon = array_create(length + ePolygon.Count);

	// Set the polygon fields
	polygon[ePolygon.Length] = length; 
									 
	// Copy the source array to the polygon
	array_copy(polygon, ePolygon.Count, set, 0, length);

	// All done!
	return polygon;
}
