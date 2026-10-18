extends Node3D

signal on_pressed()

var is_pressable = false
var time_since_pressed = 0
@export var door_ref: OpenableDoor
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$InteractableAreaButton.button_pressed.connect(_on_pressed)
	$InteractableAreaButton.button_released.connect(_on_released)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_since_pressed += delta
	if time_since_pressed >= 0.5:
		is_pressable = true

func _on_pressed(_arg):
	if is_pressable:
		is_pressable = false
		time_since_pressed = 0
		Globals.submit_button_pressed.emit()
		self.on_pressed.emit()
	
	$AudioStreamPlayer3D.stream = Globals.button_down_audio
	$AudioStreamPlayer3D.play(0)

func _on_released(_arg):
	$AudioStreamPlayer3D.stream = Globals.button_up_audio
	$AudioStreamPlayer3D.play(0)
