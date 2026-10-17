extends DialogueManager

func play():
	super.play()
	print("Button press manager playing!")

func cleanup():
	Globals.buttons_container.flight_controls_button.on_button_pressed.disconnect(self.on_flc_pressed)
	Globals.passphrase_correct.disconnect(on_success)
	Globals.passphrase_incorrect.disconnect(on_incorrect)

func wait_for_tutorial_submit():
	print("Waiting for tutorial submit!")
	Globals.buttons_container.flight_controls_button.on_button_pressed.connect(self.on_flc_pressed)
	Globals.passphrase_correct.connect(on_success)
	Globals.passphrase_incorrect.connect(on_incorrect)
	Globals.buttons_container.submit_button.on_pressed.connect(propogate_submit)
	
	self.pause()

func propogate_submit():
	Globals.main_monitor_ui_inst.tutorial_ui().submit()

func on_flc_pressed(button):
	var button_container: UIButtons = Globals.buttons_container.flight_controls_button
	var left_button = button_container.left_button
	var right_button = button_container.right_button
	if button == left_button:
		print("Pressed left tutorial")
		Globals.main_monitor_ui_inst.tutorial_ui().on_press_left()
	elif button == right_button:
		print("Pressed right tutorial")
		Globals.main_monitor_ui_inst.tutorial_ui().on_press_right()
	
func restart():
	self.current_line_idx = 0
	self.play()
	
func on_incorrect(scene):
	print_debug(scene)
	if scene is TutorialUI:
		play_next($IncorrectPress)

func on_success(scene):
	print_debug(scene)
	if scene is TutorialUI:
		cleanup()
		goto_end()
		unpause(null)
