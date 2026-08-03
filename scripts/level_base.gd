extends Node2D

var label_position_y = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$player.spawn_point = $spawn_point.position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$label.position.y = sin(label_position_y) * 16
	label_position_y += delta * 2
	$camera.zoom.y = $camera.zoom.x


func _on_player_finished() -> void:
	$animations.play("winscreen_flash")
