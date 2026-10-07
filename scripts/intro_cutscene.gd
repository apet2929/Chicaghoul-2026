extends DialogueManager

@export var title_card: Node3D
@export var clouds: Node3D
@export var subtitles: Node3D

func _ready() -> void:
	print("Ready!")
	clouds.visible = false
	title_card.visible = false
	self.cutscene_ended.connect(on_cutscene_end)
	await get_tree().create_timer(0.5).timeout
	self.play.call_deferred()
	Globals.set_camera($"../XROrigin3D/XRCamera3D")
	subtitles.position = Globals.camera.position + Vector3(0,0,-1)

func show_title_card():
	title_card.visible = true

func goto_rocket_cam():
	%Rocket.current = true
	%Rocket/XRCamera3D.current = true
	%Rocket/AnimationPlayer.play("takeoff")
	Globals.set_camera(%Rocket/XRCamera3D)
	
	
func on_cutscene_end() -> void:
	# Works if main.tscn is the currently running scene
	get_tree().root.find_child("Main", true, false).load_scene("res://scenes/game.tscn")
