extends Node

@export var palettes: Array[Resource]
@export var current_palette: palette
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func load_palette(palette_index: int = 0):
	if palette_index >= len(palettes):
		push_error("out of bounds palette")
		return
	current_palette = palettes[palette_index]
	RenderingServer.global_shader_parameter_set("color_light", palettes[palette_index].light)
	RenderingServer.global_shader_parameter_set("color_normal", palettes[palette_index].normal)
	RenderingServer.global_shader_parameter_set("color_dark", palettes[palette_index].dark)
	RenderingServer.global_shader_parameter_set("color_very_dark", palettes[palette_index].very_dark)
