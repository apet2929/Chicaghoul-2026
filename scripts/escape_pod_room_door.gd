extends StaticBody3D

@export var open_close_signal: String
func _ready() -> void:
	Globals.connect(open_close_signal, self.open_close)
	
func open_close(is_open):
	if is_open:
		$EscapePodRoomDoor/AnimationPlayer.play("open")
		self.set_collision_layer_value(1, false)
	else:
		$EscapePodRoomDoor/AnimationPlayer.play("close")
		self.set_collision_layer_value(1, true)
	
	
