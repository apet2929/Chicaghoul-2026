extends Node3D
class_name DoorsContainer

# Doesn't actually contain the doors

@onready var escape_pod_door = %EscapePodDoor
@onready var engine_room_door = %EngineRoomDoor
@onready var cargo_hold_door = %CargoHoldDoor
@onready var cockpit_door = %CockpitDoor
@onready var closet_door = %ClosetDoor

func _ready() -> void:
	Globals.doors_container = self
