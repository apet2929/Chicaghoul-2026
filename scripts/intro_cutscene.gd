extends Node3D


func xr_origin() -> XROrigin3D:
	return get_parent().find_child("XROrigin3D")

func _ready() -> void:
	%Clouds.visible = false
	
	
