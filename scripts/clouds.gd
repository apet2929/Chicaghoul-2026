extends MeshInstance3D

var alpha: float = 1
func _process(delta: float) -> void:
	if self.visible:
		self.mesh.material.uv1_offset.y += 1 * delta
		self.mesh.material.albedo_color.a = alpha
