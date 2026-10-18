@tool
extends XRToolsSceneBase
class_name Game

@onready var left_controller: XRController3D = %LeftHand
@onready var right_controller: XRController3D = %RightHand
var cockpit_door_open = false
var closet_door_open = false
func _ready() -> void:
	super._ready()
	if Engine.is_editor_hint(): # is in tool mode or are we actualyl running
		return
	
	if Globals.checkpoint != 0:
		restore_checkpoint(Globals.checkpoint)
	Globals.button_pressed.connect(self.button_pressed)
	Globals.game_over.connect(self.game_over)
	Globals.lure_played.connect(self.lure_played)
	Globals.recording_finished.connect(self.set_lure)

func _process(delta: float) -> void:
	#if left_controller.is_button_pressed("ax_button") and Globals.has_intercom:
		#equip_intercom()
	if Input.is_action_just_released("ui_left"):
		var door = $Level/Environment/Base/CockpitDoor
		Globals.open_close_cockpit_door.emit(!door._is_open)
		#door.open_close(!door._is_open)
	pass

func game_over():
	self.load_scene("res://scenes/game_over.tscn")

func equip_intercom():
	# TODO: Implement
	print_debug("Equipping intercom!")
	pass
	
# Discarding arg because of a glitch, recording doesn't work if you pass the stream around like this,
# just get it directly from the microphone.gd instance
func set_lure(audio_stream):
	for location in $Level/Locations.get_children():
		location.set_lure()
		

func restore_checkpoint(checkpoint):
	# TODO: Implement
	# Based on ID, lock & unlock doors and do whatever setup is needed
	
	if checkpoint == 0:
		print("hii :3")
	
func button_pressed(button):
	if button == Globals.buttons_container.submit_button:
		#Globals.main_monitor_ui_inst.clear()
		pass
	else: 
		pass

func lure_played(loc: Node3D):
	print("Lure played at " + str(loc.name))

func passphrase_updated(name):
	if name == %FlightControlsButtons.name:
		var tut_ui: TutorialUI = Globals.main_monitor_ui_inst.tutorial_ui()
		tut_ui.on_press_left()
		
	
func passphrase_correct(button):
	if button == %FlightControlsButtons:
		pass

func passphrase_incorrect(button):
	if button == %FlightControlsButtons:
		pass

## Sets the fade-alpha for scene transitions, allowing us to black out the
## screen for transitions.. The [param p_value] parameter must be in the range
## [0.0 - 1.0].[br][br]
##
## [b]Note[/b]: our AABB is set to be HUGE, so it should always be rendered
## unless hidden.
func set_fade(p_value: float) -> void:
	XRToolsFade.set_fade("game", Color(0, 0, 0, p_value))



func on_cancel_order_button_pressed():
	print("TODO: Play ERR Not Authorized sound effect")
