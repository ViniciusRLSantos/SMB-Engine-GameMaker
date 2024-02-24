if (surface_exists(global.view_surf)) {
	surface_free(global.view_surf);
	global.view_surf = -1;
}