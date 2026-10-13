extends RayCast3D
var _controller: XRController3D
## Input action for the Grip action in the OpenXR Action Map.
@export var grip_action := "grip"

## Input action for the Trigger action in the OpenXR Action Map.
@export var trigger_action := "trigger"

func _ready() -> void:
	_controller = XRHelpers.get_xr_controller(self)
	set_collision_mask_value(TeleportTarget.COLLISION_LAYER, true)
	

func _process(delta: float) -> void:
	print(self.is_colliding())
	if _controller == null:
		return
	if _controller.get_float(trigger_action) > 0.5 and !Globals.teleporting:
		print("Teleporting!")
		if is_colliding():
			var target = get_collider()
			print("Collided with " + str(target))
			assert(target is TeleportTarget)
			Globals.teleport_to(target)
