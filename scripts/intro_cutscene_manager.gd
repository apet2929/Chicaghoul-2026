extends DialogueManager

var cam_offset
func _ready() -> void:
	#cam_offset = %Rocket.position - %XRCamera3D.position
	#Globals.subtitle_inst = %Subtitles
	%TitleCard.visible = false
	%Clouds.visible = false
	XRServer.center_on_hmd(XRServer.RESET_BUT_KEEP_TILT, false)
	await get_tree().create_timer(0.5).timeout
	self.call_deferred("play")
	self.cutscene_ended.connect(on_cutscene_end)

func _process(delta: float) -> void:
	#%XRCamera3D.position = %Rocket.position + cam_offset
	pass

func takeoff():
	%AnimationPlayer.play("takeoff")

func show_title_card():
	%TitleCard.visible = true

func show_clouds():
	%Clouds.visible = true
	var tween = get_tree().create_tween()
	%Clouds.alpha = 0
	tween.tween_property(%Clouds, "alpha", 1, 3.0)
	
func on_cutscene_end() -> void:
	# Works if main.tscn is the currently running scene
	get_tree().root.find_child("Main", true, false).load_scene("res://scenes/game.tscn")

	
