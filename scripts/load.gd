extends ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1.6).timeout
	await View.change_scene_to_file("res://scenes/level_selection_menu_page.tscn")
	self.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
