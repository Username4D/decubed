shader_type canvas_item;

// shader used to switch color to alternative color when the bg color matches

uniform vec4 alternative_color : source_color;
uniform vec4 normal_color : source_color;

uniform sampler2D screen : hint_screen_texture, filter_linear_mipmap, source_color;


void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (distance(normal_color, texture(screen, SCREEN_UV).rgba) < 0.01) {
		float prealpha = COLOR.a;
		COLOR = alternative_color;
		COLOR.a = prealpha;
	}
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
