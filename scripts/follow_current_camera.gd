extends Node3D


func _ready() -> void:
	Globals.camera_change.connect(set_parent)

func set_parent(node: Node) -> void:
	var pos = self.position
	print("Moving to parent " + str(node.get_path()))
	self.get_parent().remove_child(self)
	node.add_child(self)
	self.position = pos
