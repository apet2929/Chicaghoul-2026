extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$IndicatorLight.set_blink(0.5)
	$IndicatorLight.run_blink()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
