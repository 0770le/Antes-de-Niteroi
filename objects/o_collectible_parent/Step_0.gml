//update light position
with(light_id) {
	x = other.x;
	y = other.y+5;
}

//flutuar
y = anchorY + sin(timer*frequency)*amplitude;
timer++;