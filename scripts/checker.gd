extends Area2D

@export var activated = false
signal update_status

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	$texture_outer.self_modulate = ColorPalettes.current_palette.dark
	$texture_inner.self_modulate = ColorPalettes.current_palette.dark
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%texture_inner.scale = %texture_inner.scale.move_toward(Vector2.ONE if activated else Vector2(0.25, 0.25), delta *1.65)


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		AudioHandler.play_sfx("switch")
		activated = true
		update_status.emit()
