extends Control

signal updated
@export var setting_name := ""
@export var visual_name := ""
@export var value := true

var initialised = false

func init(_value):
	$toggle_button.button_pressed = _value
	value = _value
	await get_tree().process_frame
	self.modulate = self.self_modulate
	self.self_modulate = Color.WHITE
	initialised = true	

func _ready() -> void:
	init(0.0)
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$setting_title.text = visual_name
	$toggle_texure_filling.visible = $toggle_button.button_pressed


func _on_toggle_button_toggled(toggled_on: bool) -> void:
	if !initialised: return
	value = toggled_on
	updated.emit()
