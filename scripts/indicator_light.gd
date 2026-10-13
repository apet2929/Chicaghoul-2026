@tool
extends Node3D

#@export var indicator_emissive_color: Color = Color(0, 1, 1, 1):
		#set(new_val):
			#indicator_emissive_color = new_val
			#set_emissive_color()
#
#@export var indicator_albedo_color: Color = Color(0, 1, 1, 1):
		#set(new_val):
			#indicator_emissive_color = new_val
			#set_emissive_color()

enum Mode {
	OFF,
	OK,
	WARNING,
	ERROR
}

@export var mode: Mode = Mode.OFF:
	set(new_mode):
		mode = new_mode
		set_mode()

const ERROR_ALBEDO = Color("a65359")
const ERROR_EMISSION = Color("ff003f")
const WARNING_ALBEDO = Color("f1d542")
const WARNING_EMISSION = Color("f1d542")
const OK_ALBEDO = Color("54eef3")
const OK_EMISSION = Color("54eef3")
const OFF_ALBEDO = Color("363932ff")
const OFF_EMISSION = Color("000000")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	set_mode()
	set_blink(blink_duration)
	
@export var blink_duration: float = 0
var blink_timer: SceneTreeTimer = null


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func set_blink(blink_duration):
	self.blink_duration = blink_duration
	blink_timer.stop()
	blink_timer.timeout.emit()
	if blink_duration > 0:
		blink_timer = get_tree().create_timer(blink_duration)
		run_blink()
	
func run_blink():
	var blink_dur = blink_duration
	while true:
		await blink_timer.timeout
		if blink_duration == blink_dur:  # check has new blink duration been set
			blink_timer.start()
		else:
			break
			

func set_colors(albedo, emissive):
	var mat = $Tip.get_active_material(0)
	mat.albedo_color = albedo
	mat.emission = emissive

func set_mode():
	var emissive_color: Color = OFF_EMISSION
	var albedo_color: Color = OFF_ALBEDO
	#var mode_key = Mode.keys()[mode]
	#print(typeof(mode_key))
	#print(mode_key)
	
	if mode == Mode.OFF:
		set_colors(OFF_ALBEDO, OFF_EMISSION)
	elif mode == Mode.OK:
		set_colors(OK_ALBEDO, OK_EMISSION)
	elif mode == Mode.WARNING:
		set_colors(WARNING_ALBEDO, WARNING_EMISSION)
	elif mode == Mode.ERROR:
		set_colors(ERROR_ALBEDO, ERROR_EMISSION)
	else:
		push_error("Invalid indicator mode! ", str(mode))
			
			
			
