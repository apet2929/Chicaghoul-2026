class_name FlickerLight
extends SpotLight3D

# Using poisson distribution 
@export var flicker_rate = 1.04
var _original_flicker_rate
func _ready() -> void:
	_original_flicker_rate = flicker_rate
	
func reset_rate():
	flicker_rate = _original_flicker_rate

#var time_since_last_flicker = 0.0
func _process(delta: float) -> void:
	var should_flicker = randf() > (0.999 / flicker_rate)
	if should_flicker and !Globals.epilepsy_protection:
		flicker()

func flicker():
	self.visible = !self.visible

func factorial(n):
	var holdvalue = 0
	var boolis = true
	if n == 0 or n == 1:
		holdvalue = 1
	else:
		while n > 0:
			if boolis:
				boolis = false
				holdvalue = n
			else:
				holdvalue = holdvalue * n
			n = n-1
