class_name ShipMonitorUI
extends Control

func show_tutorial_ui():
	clear()
	$TutorialUI.visible = true
	$TutorialUI.enable()

func tutorial_ui() -> TutorialUI:
	return $TutorialUI

func clear():
	var children = get_children()
	for child in children:
		child.visible = false
