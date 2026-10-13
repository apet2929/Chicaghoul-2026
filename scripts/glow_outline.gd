extends MeshInstance3D

@export var copied_mesh: MeshInstance3D
func _ready() -> void:
	if copied_mesh != null:
		self.mesh = copied_mesh.mesh
	
