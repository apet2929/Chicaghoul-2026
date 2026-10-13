extends DialogueManager

func _ready():
	await get_tree().create_timer(0.5).timeout
	self.play()
	self.pause()
	
func show_tutorial_ui():
	%PopupContainer.scene = load("res://scenes/popups/tutorial_ui.tscn")

func enter_alien():
	pass



func play_sfx(node: AudioStreamPlayer, name):
	node.play(name)
