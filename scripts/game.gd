@tool
extends XRToolsSceneBase

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

func _process(delta: float) -> void:
	if left_controller.is_button_pressed("trigger"):
		print("hi!")
		Globals.main_monitor_ui_inst.visible = !Globals.main_monitor_ui_inst.visible
		
	if left_controller.is_button_pressed("ax_button") and Globals.has_intercom:
		equip_intercom()

func game_over():
	self.load_scene("res://scenes/game_over.tscn")

func equip_intercom():
	# TODO: Implement
	print_debug("Equipping intercom!")
	pass
		
func restore_checkpoint(checkpoint):
	# TODO: Implement
	# Based on ID, lock & unlock doors and do whatever setup is needed
	
	if checkpoint == 0:
		print("hii :3")
	
func button_pressed(button):
	if button == %CancelOrderButton:
		print("TODO: Make err not authorized sfx")
		Globals.game_over.emit()
	elif button == %CockpitDoorLockButton:
		cockpit_door_open = !cockpit_door_open
		Globals.open_close_cockpit_door.emit(cockpit_door_open)
	elif button == %ClosetDoorLockButton:
		closet_door_open = !closet_door_open
		Globals.open_close_closet_door.emit(closet_door_open)
	elif button == Globals.buttons_container.submit_button:
		#Globals.main_monitor_ui_inst.clear()
		pass
	else: 
		pass


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
