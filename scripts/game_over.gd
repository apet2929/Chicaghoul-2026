@tool
extends XRToolsSceneBase

@export var left_hand: XRController3D
@export var right_hand: XRController3D
var pressed = false
var ready_to_restart = true
var time_in_scene = 0.0
func _ready() -> void:
	super._ready()
	await get_tree().create_timer(0.5).timeout
	$Jumpscare/AnimationPlayer.play("jumpscare")
	await $Jumpscare/AnimationPlayer.animation_finished
	$GameOverUI.visible = true

func _process(delta: float) -> void:
	time_in_scene += delta
	if time_in_scene > 2.0 and ready_to_restart and left_hand.get_float("trigger") > 0.5 or right_hand.get_float("trigger") > 0.5:
		Globals.restart_from_checkpoint()
		self.load_scene("res://scenes/game.tscn")
		ready_to_restart = false
	
