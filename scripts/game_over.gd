@tool
extends XRToolsSceneBase

@export var left_hand: XRController3D
@export var right_hand: XRController3D
func _ready() -> void:
	super._ready()
	await get_tree().create_timer(0.5).timeout
	$Jumpscare/AnimationPlayer.play("jumpscare")
	await $Jumpscare/AnimationPlayer.animation_finished
	$GameOverUI.visible = true

func _process(delta: float) -> void:
	if left_hand.get_float("trigger") > 0.5 or right_hand.get_float("trigger") > 0.5:
		print("Restarting!")
		Globals.restart_from_checkpoint()
		self.load_scene("res://scenes/game.tscn")
	
