shader_type canvas_item;

uniform int color : hint_enum("light", "normal", "dark", "very dark") = 0;
global uniform vec4 color_light;
global uniform vec4 color_normal;
global uniform vec4 color_dark;
global uniform vec4 color_very_dark;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float prealpha = COLOR.a;
	if (color == 0) {
		COLOR = color_light;
	} else if (color == 1) {
		COLOR = color_normal;
	} else if (color == 2) {
		COLOR = color_dark;
	} else if (color == 3) {
		COLOR = color_very_dark;
	}
	COLOR.a = prealpha;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
