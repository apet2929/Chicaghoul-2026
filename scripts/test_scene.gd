extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.passphrase_correct.connect(correct)
	Globals.passphrase_incorrect.connect(i)

func correct():
	print("correct!")

func i():
	print("Incorrect!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_up"):
		$PasscodeButtons/UpButton.on_pressed.emit()
	if Input.is_action_just_released("ui_down"):
		$PasscodeButtons/DownButton.on_pressed.emit()
	if Input.is_action_just_released("ui_left"):
		$PasscodeButtons/LeftButton.on_pressed.emit()
	if Input.is_action_just_released("ui_right"):
		$PasscodeButtons/RightButton.on_pressed.emit()
