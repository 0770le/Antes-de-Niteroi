/// @desc init camera
if(room != rm_paulo_gustavo and room != rm_studio_logo and room != rm_ending) {
	create_camera();
	view_camera[0] = camera;
	view_enabled = true;
	view_visible[1] = false;
	view_visible[0] = true;
}


