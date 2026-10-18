extends Node3D
class_name DoorLockContainer

@onready var cockpit_button = %CockpitDoorLockButton
@onready var engine_button = %EngineRoomDoorLockButton
@onready var cargo_button = %CargoBayDoorLockButton
@onready var closet_button = %ClosetDoorLockButton

func _ready() -> void:
	Globals.door_lock_buttons_container = self
