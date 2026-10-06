extends XRCamera3D


var offset = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	offset = %Rocket.global_position - self.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.global_position = %Rocket.global_position + offset
