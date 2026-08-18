extends Area2D

@export var activated = true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and activated:
		body.finish(self)

func _ready() -> void:
	await get_tree().process_frame
	$particles.self_modulate = ColorPalettes.current_palette.dark
