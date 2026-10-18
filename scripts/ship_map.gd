extends Control

const LOC_COCKPIT = 0
const LOC_FOYER = 1
const LOC_CLOSET = 2
const LOC_CARGO = 3
const LOC_ENGINE = 4

func _ready() -> void:
	Globals.alien_moved.connect(self.update_state)
	update_state(-1)
	
func update_state(loc_idx) -> void:
	var locs = $Locations.get_children()
	for loc in locs:
		loc.visible = false
	if loc_idx > 0 and loc_idx < locs.size():
		locs[loc_idx].visible = true 
