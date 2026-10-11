extends Node3D
class_name ShipLevel

@export var ship_monitor_font : Font

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	set_main_monitor_text("Hello, foo bar!")

func set_main_monitor_text(text):
	pass
	#var main_screen = $Base/Cockpit/Screens/MainScreen
	#if main_screen != null and main_screen.screen_inst == null:
		#main_screen.set_ui_screen_inst()
	#main_screen.screen_inst.set_text(text)
