extends Node3D

# Either indicates a door being open/closed or an alien's location
enum Mode {
	DOOR,
	ALIEN
}
@export var mode: Mode
@export var node: Node3D # if door: door, else if alien: location
@onready var indicator: IndicatorLight = $IndicatorLight

func _process(_delta: float) -> void:
	var old_mode = indicator.mode
	var new_mode = IndicatorLight.Mode.OFF
	if mode == Mode.DOOR:
		var door: OpenableDoor = node
		if door._is_open:
			new_mode = IndicatorLight.Mode.OK
		else:
			new_mode = IndicatorLight.Mode.ERROR
			
	elif mode == Mode.ALIEN:
		var loc: Location = node
		var alien: Alien = get_tree().get_first_node_in_group("alien")
		if alien.locations[alien.current_location] == loc:
			new_mode == IndicatorLight.Mode.ERROR
		else:
			new_mode = IndicatorLight.Mode.OFF
	if new_mode != old_mode:
		print(self.name + " new_mode = " + str(indicator.mode))
		indicator.mode = new_mode # don't spam update it
