extends Panel

@export var next_button_line_position = Vector2.ZERO
@export var id = 0
@export var palette_index: int = 0
signal level_button_pressed(node: Node)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$next_button_line.add_point(next_button_line_position * 2)
	$Sprite2D.rotation_degrees = 90 * randi_range(0, 3)
	$button.pressed.connect(func(): level_button_pressed.emit(self))

func update_palette():
	$Sprite2D.modulate = ColorPalettes.palettes[palette_index].dark
	$next_button_line.modulate = ColorPalettes.palettes[palette_index].dark
	self.self_modulate = ColorPalettes.palettes[palette_index].normal

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$level_label.text = str(id)
