extends StaticBody3D
class_name OpenableDoor

@export var open_close_signal: String
@export var _is_open = false
func _ready() -> void:
	Globals.connect(open_close_signal, self.open_close)
	open_close(_is_open)

func open_close(is_open):
	print_debug(self.name + " " + str(is_open))
	if is_open:
		print("Opening " + str(self.name))
		$EscapePodRoomDoor/AnimationPlayer.play("open")
		self.set_collision_layer_value(1, false)
	else:
		print("Closing " + str(self.name))
		$EscapePodRoomDoor/AnimationPlayer.play("close")
		self.set_collision_layer_value(1, true)
		
	self._is_open = is_open
	
	
