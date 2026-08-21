extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$background.visible = true
	apply_palette(self, ColorPalettes.current_palette)
	for i in $settings.get_children():
		i.init(SettingsHandler.settings[i.setting_name])
		i.updated.connect(func(): update(i))
		i.modulate = ColorPalettes.current_palette.dark
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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

func update(node: Node):
	SettingsHandler.settings[node.setting_name] = node.value
	SettingsHandler.sdk_save()


func _on_exit_button_pressed() -> void:
	View.show_transition()
	await View.transition_midpoint
	await get_tree().process_frame
	View.change_scene_to_file("res://scenes/main_menu.tscn", true, true)


func _on_credits_button_pressed() -> void:
	$credits.visible = true



func _on_credits_exit_button_pressed() -> void:
	$credits.visible = false
