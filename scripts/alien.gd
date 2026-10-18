extends Node3D
class_name Alien

# TODO: Unnecessary?
@export var loc_cockpit: Node3D
@export var loc_foyer: Node3D
@export var loc_closet: Node3D
@export var loc_cargo: Node3D
@export var loc_engine: Node3D
@export var current_location = 0 # index into locations
@export var door_cockpit: OpenableDoor
@export var door_closet: OpenableDoor
@export var door_cargo: OpenableDoor
@export var door_engine: OpenableDoor

@onready var move_sound = preload("res://assets/me/audio/downloaded/freesound_community-basstinhitsnd-91455.mp3")


const LOC_COCKPIT = 0
const LOC_FOYER = 1
const LOC_CLOSET = 2
const LOC_CARGO = 3
const LOC_ENGINE = 4

const enable_debug = true

var locations: Array[Node3D]
var doors: Array[OpenableDoor]
@export var player_ref: XRToolsPlayerBody 
var lured_location_idx = -1
var lured_time: float = 0.0 # time since lured, used to deactivate lure
const LURE_EFFECTIVE_TIME = 60

func debug(msg):
	if enable_debug:
		print(msg)

func _ready() -> void:
	if Globals.checkpoint_alien_location != -1:
		self.current_location = Globals.checkpoint_alien_location
	locations = [loc_cockpit, loc_foyer, loc_closet, loc_cargo, loc_engine]
	$Timer.timeout.connect(move)
	#self.update_position_to_current_loc()
	Globals.lure_played.connect(self.lure_played)

func _process(delta: float) -> void:
	lured_time += delta
	if lured_time > LURE_EFFECTIVE_TIME:
		lured_location_idx = -1

func lure_played(loc):
	debug("Alien- lure played!")
	for i in range(len(locations)):
		if loc == locations[i]:
			self.lured_time = 0
			self.lured_location_idx = i
			debug("lured to " + str(i))

func move():
	if $Timer.is_stopped():
		debug("Starting timer!")
		$Timer.start()
	
	var loc = get_next_location()
	if loc >= 0:
		current_location = loc
	debug("moving to " + str(locations[loc].name))
	Globals.alien_moved.emit(loc)
	update_position_to_current_loc()
	if current_location == players_location():
		Globals.game_over.emit()

func update_position_to_current_loc():
	Globals.checkpoint_alien_location = current_location
	var loc = locations[current_location]
	assert(loc.pose_ref != null)
	self.global_position = loc.pose_ref.global_position


func players_location() -> int:
	var min_dist = 1000000000
	var closest_target = -1
	var player_loc = player_ref.global_position
	for i in range(len(locations)):
		var d =  player_loc.distance_to(locations[i].global_position)
		if d < min_dist:
			min_dist = d
			closest_target = i
	return closest_target

func closest_location_to(target_node: Node3D):
	var min_dist = 1000000000
	var closest_target = -1
	var target_loc = target_node.global_position
	for i in range(len(locations)):
		var d = target_loc.distance_to(locations[i].global_position)
		if d < min_dist:
			min_dist = d
			closest_target = i
	return closest_target
	
func closest_moveable_location_to(target_node: Node3D, moveable_locs):
	var min_dist = 1000000000
	var closest_target = -1
	var target_loc = target_node.global_position
	for loc in moveable_locs.keys():
		if moveable_locs[loc]:
			var d = target_loc.distance_to(locations[loc].global_position)
			if d < min_dist:
				min_dist = d
				closest_target = loc
			debug("dist from " + locations[loc].name + " to " + target_node.name + " = " + str(d))
	return closest_target

func get_next_location() -> int:
	var goto_location
	if lured_location_idx != -1:
		goto_location = locations[lured_location_idx]
	else:
		goto_location = locations[players_location()]
	debug("goto_location= " + str(goto_location.name))
	var moveable = moveble_locations(current_location)
	debug("moveable_locations= " + str(moveable))
	return closest_moveable_location_to(goto_location, moveable)

func can_move_from_to(loc_a, loc_b):
	if loc_a == LOC_CARGO:
		if loc_b == LOC_ENGINE:
			return door_engine._is_open
		elif loc_b == LOC_FOYER:
			return door_cargo._is_open
		else:
			return false
	elif loc_a == LOC_ENGINE:
		if loc_b == LOC_CLOSET:
			return true
		if loc_b == LOC_CARGO:
			return door_engine._is_open
	elif loc_a == LOC_COCKPIT:
		if loc_b == LOC_FOYER:
			return door_cockpit._is_open
		else:
			return false
	elif loc_a == LOC_CLOSET:
		if loc_b == LOC_FOYER:
			return door_closet._is_open
		if loc_b == LOC_ENGINE:
			return true
		else:
			return false
	elif loc_a == LOC_FOYER:
		if loc_b == LOC_CARGO:
			return door_cargo._is_open
		elif loc_b == LOC_CLOSET:
			return door_closet._is_open
		elif loc_b == LOC_COCKPIT:
			return door_cockpit._is_open
		else:
			return false
			
func moveble_locations(loc):
	if loc == LOC_CARGO:
		return {
			LOC_CARGO: true,
			LOC_ENGINE: door_engine._is_open,
			LOC_FOYER: door_cargo._is_open
		}
	elif loc == LOC_ENGINE:
		return {
			LOC_ENGINE: true,
			LOC_CLOSET: true,
			LOC_CARGO: door_engine._is_open,
		}
	elif loc == LOC_COCKPIT:
		return {
			LOC_COCKPIT: true,
			LOC_FOYER:door_cockpit._is_open,
		}
	elif loc == LOC_CLOSET:
		return {
			LOC_CLOSET: true,
			LOC_FOYER: door_closet._is_open,
			LOC_ENGINE: true
		}
	elif loc == LOC_FOYER:
		return {
			LOC_FOYER: true,
			LOC_CARGO: door_cargo._is_open,
			LOC_CLOSET: door_closet._is_open,
			LOC_COCKPIT: door_cockpit._is_open
		}
	else:
		debug("huuuh??? " + str(loc))
		push_error("huh????!?!?")
		return {}
	
		
