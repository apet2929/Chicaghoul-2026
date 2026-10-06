class_name Subtitle
extends Control

func _ready() -> void:
	Globals.subtitle_inst = self
	
#func _process(delta: float) -> void:
	## Always make self a direct child of 
	#var cam = get_viewport().get_camera_3d()
	#if get_parent() != cam and cam != null:
		#var local_position = self.position
		#var local_rotation = self.rotation
		#get_parent().remove_child(self)
		#cam.add_child(self)
		##self.position = local_position
		##self.rotation = local_rotation

func set_line(line: String):
	$RichTextLabel.text = line
