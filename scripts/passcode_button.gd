extends Node3D

signal on_pressed()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$InteractableAreaButton.button_pressed.connect(_on_pressed)
	$InteractableAreaButton.button_released.connect(_on_released)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed(_arg):
	self.on_pressed.emit()
	$AudioStreamPlayer3D.stream = Globals.button_down_audio
	$AudioStreamPlayer3D.play(0)

func _on_released(_arg):
	$AudioStreamPlayer3D.stream = Globals.button_up_audio
	$AudioStreamPlayer3D.play(0)
