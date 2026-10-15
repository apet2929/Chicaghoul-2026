extends SpotLight3D

@export var rot_amp: Vector3 = Vector3(PI * 0.3, 2 * PI, PI * 0.3)
@export var rot_freq: Vector3 = Vector3(1, 0.2, 1)
var thetas = Vector3(0,0, 0)

func _process(delta: float) -> void:
	var thetas = thetas + Vector3(delta * rot_freq.x, delta * rot_freq.y, delta * rot_freq.z)
	var new_rotation = (rot_amp * Vector3(sin(thetas.x), sin(thetas.y), sin(thetas.z)))
	self.global_rotation = new_rotation
	
