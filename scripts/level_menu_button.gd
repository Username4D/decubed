extends Panel

@export var next_button_line_position = Vector2.ZERO
@export var id = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$next_button_line.add_point(next_button_line_position * 2)
	$Sprite2D.rotation_degrees = 90 * randi_range(0, 3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$level_label.text = str(id)
