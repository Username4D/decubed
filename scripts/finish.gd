extends Area2D

@export var activated = true

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player") and activated:
		AudioHandler.play_sfx("finish")
		body.finish(self)

func _ready() -> void:
	await get_tree().process_frame
	self.modulate = ColorPalettes.current_palette.dark
	if SettingsHandler.settings["particles_enabled"]:
		$particles.visible = true
		$a.visible = false
		$aa.visible = false
		$aa.visible = false
		$aa.visible = false
		
