@tool
extends Node3D
class_name IndicatorLight

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
const OFF_ALBEDO = Color("9ba094")
const OFF_EMISSION = Color("000000")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(get_children())
	set_mode()
	set_blink(blink_duration)
	$BlinkTimer.timeout.connect(_blink)
	if blink_running:
		run_blink()

@export var blink_duration: float = 1.0
@onready var blink_timer: Timer = $BlinkTimer
@export var blink_running = false
var _blink_on: bool = false


func set_blink(blink_duration: float):
	self.blink_duration = blink_duration
	assert(blink_duration > 0)
	blink_timer.wait_time = blink_duration

func run_blink():
	blink_running = true
	blink_timer.start()

func pause_blink():
	blink_running = false
	if blink_timer != null:
		blink_timer.stop()
		blink_timer.timeout.emit()
		

func _blink():
	_blink_on = !_blink_on
	if _blink_on:
		set_mode()
	else:
		set_colors(OFF_ALBEDO, OFF_EMISSION)

func set_colors(albedo, emissive):
	if not is_inside_tree():
		return
	var mat = $Tip.get_active_material(0)
	mat.albedo_color = albedo
	mat.emission = emissive

func set_mode():
	if not is_inside_tree():
		return
	var emissive_color: Color = OFF_EMISSION
	var albedo_color: Color = OFF_ALBEDO
	
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
			
			
			
