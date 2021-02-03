/// @desc Draws the composited shadow map
/// @arg x The X position at which to draw the shadow map
/// @arg y The Y position at which to draw the shadow map
function draw_shadow_map(argument0, argument1) {

	var X = argument0;
	var Y = argument1;
	var surface = global.worldShadowMap;

	gpu_set_blendmode(bm_subtract);
	shader_set(__WORLD_SHADOW_MAP_SHADER);
		shader_set_uniform_f(global.u_FilmGrainSpeed, global.FilmGrainSpeed);
		shader_set_uniform_f(global.u_FilmGrainStrength, global.FilmGrainStrength);
		shader_set_uniform_f(global.u_AmbientShadow, global.ambientShadowIntensity);
		shader_set_uniform_f_array(global.u_TexelSize_ShadowMap, [1.0 / surface_get_width(surface), 1.0 / surface_get_height(surface)]);
		draw_surface(surface, X, Y);
	shader_reset();
	gpu_set_blendmode(bm_normal);
}
