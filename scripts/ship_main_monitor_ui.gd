class_name ShipMonitorUI
extends Control


func _ready() -> void:
	pass

func set_text(text):
	$RichTextLabel.text = text
	

func clear():
	var children = get_children()
	for child in children:
		child.visible = false
