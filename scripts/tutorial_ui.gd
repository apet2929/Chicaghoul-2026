class_name TutorialUI
extends Control

var state = 0

func _process(delta: float) -> void:
	if Input.is_action_just_released("ui_left"):
		on_press_left()
	elif Input.is_action_just_released("ui_right"):
		on_press_right()
	
func enable():
	state = 0

func disable():
	state = 2

func on_press_left():
	$Background.visible = false
	state -= 1
	state = clamp(state, 0, 2)
	#print(state)
	update_state()
	
func on_press_right():
	state += 1
	state = clamp(state, 0, 2)
	update_state()
	
func update_state():
	for i in range(3):
		var is_visible = state == i
		get_node("State" + str(i)).visible = is_visible
		#print(str(i) + " is visible = " + str(is_visible))
	self.queue_redraw()

func submit():
	if state == 2:
		Globals.passphrase_correct.emit(self)
	else:
		Globals.passphrase_incorrect.emit(self)
