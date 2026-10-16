@tool
extends XRToolsSceneBase

@onready var left_controller: XRController3D = %LeftHand
@onready var right_controller: XRController3D = %RightHand

func _ready() -> void:
	super._ready()
	if !Engine.is_editor_hint(): # is in tool mode or are we actualyl running
		Globals.on_teleport.connect(teleport_player)

func _process(delta: float) -> void:
	if left_controller.is_button_pressed("trigger"):
		print("hi!")


func teleport_player(teleport_target: TeleportTarget):
	if !Globals.teleporting:  # Poor man's mutex
		Globals.teleporting = true
		print("Running teleport_player!")
		var tween = get_tree().create_tween()
		tween.tween_method(set_fade, 0.0, 1.0, 1.0)
		await tween.finished
		tween.kill()
		$XROrigin3D.global_position = teleport_target.global_position + Vector3(0,1.5,0)
		tween = get_tree().create_tween()
		tween.tween_method(set_fade, 1.0, 0.0, 1.0)
		await tween.finished
		tween.kill()
		Globals.teleporting = false

## Sets the fade-alpha for scene transitions, allowing us to black out the
## screen for transitions.. The [param p_value] parameter must be in the range
## [0.0 - 1.0].[br][br]
##
## [b]Note[/b]: our AABB is set to be HUGE, so it should always be rendered
## unless hidden.
func set_fade(p_value: float) -> void:
	XRToolsFade.set_fade("game", Color(0, 0, 0, p_value))
