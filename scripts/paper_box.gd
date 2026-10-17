extends Node3D

func _ready() -> void:
	$PickablePaper.dropped.connect(self.on_dropped)

func on_dropped(paper):
	$SnapZone.pick_up_object(paper)
