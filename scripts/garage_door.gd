extends Node3D

signal highlight_updated(pickable: XRToolsPickable, enable: bool)
@export var controllers: Array[XRController3D]
var hands_inside = []
func _on_hand_pose_area_body_entered(body: Node3D) -> void:
	highlight_updated.emit(null, true)
	if !hands_inside.has(body):
		hands_inside.append(body)

func _on_hand_pose_area_body_exited(body: Node3D) -> void:
	hands_inside.erase(body)
	if hands_inside.is_empty():
		highlight_updated.emit(null, false)

func _process(delta: float) -> void:
	for cont in controllers:
		if cont.get_float("trigger") > 0.5 and !hands_inside.is_empty():
			open()

func open():
	$AnimationPlayer.play("up")
	
