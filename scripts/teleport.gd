extends RayCast3D

func _ready() -> void:
	set_collision_mask_value(TeleportTarget.COLLISION_LAYER, true)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("trigger_left"):
		print("Teleporting!")
		if is_colliding():
			var target = get_collider()
			print("Collided with " + str(target))
			assert(target is TeleportTarget)
			Globals.teleport_to(target)
