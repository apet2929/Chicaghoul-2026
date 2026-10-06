extends Node


func xr_origin() -> XROrigin3D:
	return get_parent().find_child("XROrigin3D")

func _ready() -> void:
	print("Ready!")
	%Clouds.visible = false
	%RocketCam/TitleCard.visible = false
	$DialogueManager.cutscene_ended.connect(on_cutscene_end)
	await get_tree().create_timer(0.5).timeout
	self.start_cutscene.call_deferred()
	
func start_cutscene():
	$DialogueManager.play()
	%Rocket/AnimationPlayer.play("takeoff")

func show_title_card():
	%RocketCam.current = true
	%RocketCam/TitleCard.visible = true
	
func on_cutscene_end() -> void:
	# Works if main.tscn is the currently running scene
	get_tree().root.find_child("Main", true, false).load_scene("res://scenes/game.tscn")
