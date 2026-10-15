extends Node3D

signal on_pressed()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$InteractableAreaButton.button_pressed.connect(_on_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_pressed(_arg):
	self.on_pressed.emit()
