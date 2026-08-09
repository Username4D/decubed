extends Node2D	

var current_screen = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	%left_button_texture.visible = current_screen > 0
	%right_button_texture.visible = current_screen != $menu_pages.get_child_count() - 1

func _on_left_button_pressed() -> void:
	current_screen -= 1
	$camera.position =Vector2(1152 * current_screen + 576, $camera.position.y)


func _on_right_button_pressed() -> void:
	current_screen += 1
	$camera.position =Vector2(1152 * current_screen + 576, $camera.position.y)
