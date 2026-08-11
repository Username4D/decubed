extends Node2D

@export var palette_index: int = 0

var label_position_y = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$end_screen.visible = false
	$player.spawn_point = $spawn_point.position
	await ColorPalettes.load_palette(palette_index)
	$background.visible = true
	$background_tilemap.self_modulate = ColorPalettes.palettes[palette_index].normal
	$foreground_tilemap.self_modulate = ColorPalettes.palettes[palette_index].very_dark
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$label.position.y = sin(label_position_y) * 8
	label_position_y += delta * 2
	$camera.zoom.y = $camera.zoom.x


func _on_player_finished() -> void:
	$animations.play("winscreen_flash")

func _on_player_death() -> void:
	$animations.play("death_flash")


func _on_menu_button_pressed() -> void:
	View.show_transition()
	await View.transition_midpoint
	await get_tree().process_frame
	View.change_scene_to_file("res://scenes/level_menu_pages_host.tscn", true, true)




func _on_next_button_pressed() -> void:
	if ResourceLoader.exists("res://scenes/levels/%d.tscn" % (int(self.name) + 1)):
		View.show_transition()
		await View.transition_midpoint
		await get_tree().process_frame
		View.change_scene_to_file("res://scenes/levels/%d.tscn" % (int(self.name) + 1), true, true)
	else:
		push_error("level not found")
