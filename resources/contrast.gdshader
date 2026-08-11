shader_type canvas_item;

// shader used to switch color to alternative color when the bg color matches
instance uniform int color : hint_enum("light", "normal", "dark", "very dark");
instance uniform int alternative_color : hint_enum("light", "normal", "dark", "very dark");
global uniform vec4 color_light;
global uniform vec4 color_normal;
global uniform vec4 color_dark;
global uniform vec4 color_very_dark;

uniform sampler2D screen : hint_screen_texture, filter_linear_mipmap, source_color;

vec4 id_to_color(int id) {
	switch (id) {
		case 0:
			return color_light;
		case 1:
			return color_normal;
		case 2:
			return color_dark;
		case 3:
			return color_very_dark;
	}
}

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (distance(id_to_color(color), texture(screen, SCREEN_UV).rgba) < 0.01) {
		float prealpha = COLOR.a;
		COLOR = id_to_color(alternative_color);
		COLOR.a = prealpha;
	}
	else {
		float prealpha = COLOR.a;
		COLOR = id_to_color(color);
		COLOR.a = prealpha;
	}
}



//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
