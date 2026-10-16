@tool
extends XRToolsFade

@export var fade_level: float = 0.0 : 
	set(val):
		fade_level = val
		set_val(val)

func set_val(val):
	XRToolsFade.set_fade("game", Color(0, 0, 0, val))
	
func play_anim(anim: String):
	$AnimationPlayer.play(anim)

func move_player():
	Globals.teleport_middle.emit()

func teleport_end():
	Globals.teleporting = false
