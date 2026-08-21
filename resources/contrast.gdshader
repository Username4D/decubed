shader_type canvas_item;

// shader used to switch color to alternative color when the bg color matches

global uniform vec4 color_light;
global uniform vec4 color_dark;

uniform sampler2D screen : hint_screen_texture, filter_linear_mipmap, source_color;



void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (distance(color_dark, texture(screen, SCREEN_UV).rgba) < 0.01) {
		float prealpha = COLOR.a;
		COLOR = color_light;
		COLOR.a = prealpha;
	}
	else {
		float prealpha = COLOR.a;
		COLOR = color_dark;
		COLOR.a = prealpha;
	}
}



//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
