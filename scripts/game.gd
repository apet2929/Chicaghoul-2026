@tool
extends XRToolsSceneBase

func _ready() -> void:
	Globals.on_teleport.connect(teleport_player)

func teleport_player(teleport_target: TeleportTarget):
	print("Running teleport_player!")
	var tween = get_tree().create_tween()
	tween.tween_method(set_fade, 0.0, 1.0, 1.0)
	await tween.finished

	$XROrigin3D.global_transform = teleport_target.global_transform


## Sets the fade-alpha for scene transitions, allowing us to black out the
## screen for transitions.. The [param p_value] parameter must be in the range
## [0.0 - 1.0].[br][br]
##
## [b]Note[/b]: our AABB is set to be HUGE, so it should always be rendered
## unless hidden.
func set_fade(p_value: float) -> void:
	XRToolsFade.set_fade("game", Color(0, 0, 0, p_value))
