extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1.6).timeout
	while $loading_label.self_modulate.a != 0:
		await get_tree().process_frame
		$epilepsy_warning.self_modulate.a = clamp($loading_label.self_modulate.a, 0, 1)
		$loading_label.self_modulate.a = move_toward($loading_label.self_modulate.a, 0, get_process_delta_time() * 3)
	View.show_transition_out()
	await get_tree().process_frame
	await View.change_scene_to_file("res://scenes/main_menu.tscn")

	self.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
