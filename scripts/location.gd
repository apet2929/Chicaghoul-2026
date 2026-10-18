extends Marker3D
class_name Location

@onready var pose_ref = $PoseRef

func _ready() -> void:
	Globals.lure_played.connect(self.play_lure)

func set_lure():
	$Lure.stream = get_tree().get_first_node_in_group("microphone1").recording

func play_lure(loc):
	if loc == self:
		$Lure.play()
