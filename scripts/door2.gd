extends StaticBody3D

signal highlight_updated(pickable: XRToolsPickable, enable: bool)
@export var controllers: Array[XRController3D]
var hands_inside = []
var original_position: Vector3
@export var open_position_ref: Node3D
var open_position: Vector3
var is_open: bool = false

func _ready() -> void:
	original_position = self.global_position
	if open_position_ref != null:
		open_position = open_position_ref.global_position
	else:
		open_position = original_position + Vector3(0, 3, 0)

func _on_hand_area_3d_body_entered(body: Node3D) -> void:
	print("Hand entered!", str(body))
	highlight_updated.emit(null, true)
	if !hands_inside.has(body):
		hands_inside.append(body)

func _on_hand_area_3d_body_exited(body: Node3D) -> void:
	hands_inside.erase(body)
	print("Hand exited! " + str(body) + " :=> " + str(hands_inside.size()) + " hands remaining")
	if hands_inside.is_empty():
		highlight_updated.emit(null, false)

func _process(delta: float) -> void:
	for cont in controllers:
		if cont.get_float("trigger") > 0.5 and !hands_inside.is_empty():
			print("Opening!")
			is_open = true
		elif cont.is_button_pressed("ax_button"):
			print("Closing!")
			is_open = false

func _physics_process(delta: float) -> void:
	if is_open:
		self.global_position = lerp(self.global_position, self.open_position, delta)
	else:
		self.global_position = lerp(self.global_position, self.original_position, delta)
