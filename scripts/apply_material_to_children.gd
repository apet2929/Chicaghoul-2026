@tool
extends Node
@onready var material = load("res://assets/shaders/quant_colormap.tres")
func _ready() -> void:
	var c = find_children("*", "MeshInstance3D", true, false)
	for child in c:
		var ca: MeshInstance3D = child
		for i in range(ca.mesh.get_surface_count()):
			ca.set_surface_override_material(i, material)
			
