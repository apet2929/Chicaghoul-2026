@tool
extends XRToolsSceneBase

@onready var left_controller: XRController3D = %LeftHand
@onready var right_controller: XRController3D = %RightHand

func _ready() -> void:
	super._ready()
	if !Engine.is_editor_hint() and is_inside_tree(): # is in tool mode or are we actualyl running
		Globals.on_teleport.connect(teleport_player)

func _process(delta: float) -> void:
	if left_controller.is_button_pressed("trigger"):
		print("hi!")


func teleport_player(teleport_target: TeleportTarget):
	if !Globals.teleporting:  # Poor man's mutex
		Globals.teleporting = true
		Globals.teleport_middle.connect((func ():
			$XROrigin3D.global_position = teleport_target.global_position + Vector3(0,1.5,0)
		), ConnectFlags.CONNECT_ONE_SHOT)
		$AnimationPlayer.play("teleport")
		
		Globals.teleporting = false
		#set_fade(0)
		
@export var fade_level: float = 0.0 : 
	set(val):
		fade_level = val
		set_val(val)

func set_val(val):
	if is_inside_tree() and !Engine.is_editor_hint():
		print("set val " + str(val))
		#XRToolsFade.set_fade("game", Color(0, 0, 0, val))
	
func play_anim(anim: String):
	$AnimationPlayer.play(anim)

func move_player():
	Globals.teleport_middle.emit()

func teleport_end():
	Globals.teleporting = false
