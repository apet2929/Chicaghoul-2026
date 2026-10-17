extends StaticBody3D
class_name TeleportTarget

@export var enabled = true
# TODO: Enable and disable as needed

const COLLISION_LAYER = 25
func _ready() -> void:
	self.set_collision_layer_value(COLLISION_LAYER, true)
	#self.set_collision_mask_value(COLLISION_LAYER, true) # I don't think I need this?
	
	
