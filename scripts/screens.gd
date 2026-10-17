extends Node3D

#@onready var main_screen = $MainScreen
var monitors = []

func _ready() -> void:
	monitors = [
		#$"computer-screen",
		#$"MainScreen",
		$"computer-screen1",
		$"computer-screen2",
		$"computer-screen3",
		$"computer-screen5",
		#$"computer-system",
		#$"computer-system2",
		#$"computer-system3",
	]
	
	#for monitor in monitors:
		#Globals.monitors[monitor.name] = monitor
