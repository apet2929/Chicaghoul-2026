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
		$PasscodeButtons/UpButton._on_pressed(null)
		await get_tree().create_timer(0.5).timeout
		$PasscodeButtons/UpButton._on_released(null)
	if Input.is_action_just_released("ui_down"):
		$PasscodeButtons/DownButton._on_pressed(null)
		await get_tree().create_timer(0.5).timeout
		$PasscodeButtons/DownButton._on_released(null)
	if Input.is_action_just_released("ui_left"):
		$PasscodeButtons/LeftButton._on_pressed(null)
		await get_tree().create_timer(0.5).timeout
		$PasscodeButtons/LeftButton._on_released(null)
	if Input.is_action_just_released("ui_right"):
		$PasscodeButtons/RightButton._on_pressed(null)
		await get_tree().create_timer(0.5).timeout
		$PasscodeButtons/RightButton._on_released(null)
		
	if Input.is_action_just_pressed("ui_accept"):
		$PickablePaper.picked_up.emit(null)
		$PickablePaper.dropped.emit(null)
