extends Node2D

@export var offset = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for i in $level_buttons.get_children():
		i.id = int(i.name) + offset
		i.level_button_pressed.connect(launch_level)
func launch_level(button_node: Node):
	get_tree().change_scene_to_file("res://scenes/levels/%d.tscn" % button_node.id)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
