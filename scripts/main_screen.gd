extends Node3D

func get_ui() -> ShipMonitorUI:
	return $Viewport2Din3D.scene_node
	
func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	Globals.main_monitor_ui_inst = get_ui()
	print(Globals.main_monitor_ui_inst.get_instance_id())
	#Globals.ui_init.emit()
