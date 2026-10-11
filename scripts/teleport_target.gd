extends Area3D
class_name TeleportTarget

const COLLISION_LAYER = 18
func _ready() -> void:
	self.set_collision_layer_value(COLLISION_LAYER, true)
	#self.set_collision_mask_value(COLLISION_LAYER, true) # I don't think I need this?
	
	
