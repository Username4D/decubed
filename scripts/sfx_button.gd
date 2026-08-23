extends Button

class_name SfxButton
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(func(): AudioHandler.play_sfx("input"))
	#mouse_entered.connect(func(): AudioHandler.play_sfx("hover"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
