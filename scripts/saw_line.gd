extends Line2D

var current_saw_point = 1
var saw_speed = 200
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$saw.position = self.points[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	$saw.position = $saw.position.move_toward(self.points[current_saw_point], delta * saw_speed)
	if $saw.position == self.points[current_saw_point]:
		current_saw_point = current_saw_point + 1 if current_saw_point + 1 < len(self.points) else 0
		
