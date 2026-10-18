extends Node
class_name AmbienceManager

func _ready() -> void:
	Globals.ambience_manager = self
	Globals.passphrase_correct.connect(play_correct)
	Globals.passphrase_incorrect.connect(play_incorrect)
	Globals.passphrase_updated.connect(play_updated)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		play_updated(null)

func play_alarm():
	$Alarm.play()

func stop_alarm():
	$Alarm.stop()

func play_correct(_arg):
	$CorrectBuzzer.play()
	
func play_updated(_arg):
	print("playing updated buzzer")
	$UpdatedBuzzer.play()
	
func play_incorrect(_arg):
	$IncorrectBuzzer.play()
