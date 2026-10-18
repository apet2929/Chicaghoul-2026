extends Control

@onready var cockpit_door = $DoorCockpit
@onready var cargo_door = $DoorCargo
@onready var engine_door = $DoorEngine
@onready var closet_door = $DoorCloset
@onready var escape_pod_door = $DoorEscapePod

var closed_color = Color("ff1f1f")
var open_color = Color("ff1f1f3e")

func _process(delta: float) -> void:
	update_door(cargo_door, Globals.doors_container.cargo_hold_door._is_open)
	update_door(cockpit_door, Globals.doors_container.cockpit_door._is_open)
	update_door(engine_door, Globals.doors_container.engine_room_door._is_open)
	update_door(closet_door, Globals.doors_container.closet_door._is_open)
	update_door(escape_pod_door, Globals.doors_container.escape_pod_door._is_open)

func update_door(door: TextureRect, is_open):
	if is_open:
		door.modulate = open_color
	else:
		door.modulate = closed_color
