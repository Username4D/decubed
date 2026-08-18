extends Node2D

var label_position_y = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$background.visible = true
	$animation.play("intro")
	apply_palette(self, ColorPalettes.palettes[randi_range(0, clamp(len(ColorPalettes.palettes) - 1, 0, floori(SettingsHandler.unlocked_levels / 10)))])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$title_label.position.y = sin(label_position_y) * 8 + 256
	label_position_y += delta * 2


func _on_play_button_pressed() -> void:
	View.show_transition()
	await View.transition_midpoint
	await get_tree().process_frame
	await View.change_scene_to_file("res://scenes/level_menu_pages_host.tscn", true, true)

func apply_palette(node: Node, pal: palette):
	if node.is_in_group("color_light"):
		node.self_modulate = pal.light
	if node.is_in_group("color_normal"):
		node.self_modulate = pal.normal
	if node.is_in_group("color_dark"):
		node.self_modulate = pal.dark
	if node.is_in_group("color_very_dark"):
		node.self_modulate = pal.very_dark
	if node.get_child_count() != 0:
		for i in node.get_children():
			apply_palette(i, pal)
