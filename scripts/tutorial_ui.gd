class_name TutorialUI
extends Control

var state = 0

func _ready() -> void:
	Globals.submit_button_pressed.connect(self.submit)
	print_debug("loading TutorialUI!")

func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_left"):
		on_press_left()
	elif Input.is_action_just_released("ui_right"):
		on_press_right()
	
func enable():
	print_debug("enabling!")
	Globals.submit_button_pressed.connect(self.submit)
	state = 0

func disable():
	print_debug("disabling!")
	Globals.submit_button_pressed.disconnect(self.submit)
	state = 2

func on_press_left():
	$Background.visible = false
	print_debug("pressing left!")
	state -= 1
	state = clamp(state, 0, 2)
	print(state)
	update_state()
	
func on_press_right():
	print_debug("pressing right!")
	state += 1
	state = clamp(state, 0, 2)
	update_state()
	
func update_state():
	for i in range(3):
		var is_visible = state == i
		get_node("State" + str(i)).visible = is_visible
		print(str(i) + " is visible = " + str(is_visible))
	self.queue_redraw()

func submit():
	if state == 2:
		Globals.passphrase_correct.emit(self)
	else:
		Globals.passphrase_incorrect.emit(self)
