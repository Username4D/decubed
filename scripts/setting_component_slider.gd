extends Control

signal updated
@export var setting_name := ""
@export var visual_name := ""
@export var value := 0.0
@export var range_max := 10.0
@export var range_min := 0.0

var initialised = false

func init(_value):
	$slider.value = _value
	value = _value
	await get_tree().process_frame
	self.modulate = self.self_modulate
	self.self_modulate = Color.WHITE
	initialised = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$slider.min_value = range_min
	$slider.max_value = range_max
	init(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$setting_title.text = visual_name


func _on_slider_drag_ended(value_changed: bool) -> void:
	if !value_changed or !initialised: return
	value = $slider.value
	updated.emit()
