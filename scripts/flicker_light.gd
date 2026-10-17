class_name FlickerLight
extends SpotLight3D

# Using poisson distribution 
@export var flicker_rate = 1.04
#var time_since_last_flicker = 0.0
func _process(delta: float) -> void:
	var should_flicker = randf() > (0.999 / flicker_rate)
	if should_flicker:
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
