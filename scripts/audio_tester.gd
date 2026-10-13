@tool
extends TextureRect

@export_tool_button("Hello") var hello_action = hello
@export_tool_button("Randomize the color!", "ColorRect") var randomize_color_action = randomize_color

func hello():
	print("Hello world!")
	$AudioStreamPlayer.playing = !$AudioStreamPlayer.playing
	

func randomize_color():
	pass
	#var undo_redo = EditorInterface.get_editor_undo_redo()
	#undo_redo.create_action("Randomized Sprite2D Color")
	#undo_redo.add_do_property(self, &"self_modulate", Color(randf(), randf(), randf()))
	#undo_redo.add_undo_property(self, &"self_modulate", self_modulate)
	#undo_redo.commit_action()
