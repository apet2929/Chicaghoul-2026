extends DialogueManager

func play():
	super.play()

func wait_for_button_press():
	Globals.button_pressed.connect(self.on_pressed)
	self.pause()

func on_pressed(button):
	Globals.button_pressed.disconnect(self.on_pressed)
	if button == %TutorialButtonContainer:
		on_success()
	else:
		Globals.button_pressed.connect(self.on_pressed)
		play_next($IncorrectPress)
	unpause(null)
	
func restart():
	self.current_line_idx = 0
	self.play()
	
func on_success():
	pass
