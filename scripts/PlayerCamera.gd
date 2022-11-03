extends Camera3D


# Called when the node enters the scene tree for the first time.
var mode = "persp"
var dir = "front"
@onready var pixelShader = preload("res://shaders/pixelated.gdshader")
@onready var twistShader = preload("res://shaders/twisted.gdshader")
var pixelMat = ShaderMaterial.new()
var twistMat = ShaderMaterial.new()
@onready var twistedTimer = get_node("TwistedTimer")
func _ready():
	pixelMat.shader = pixelShader
	twistMat.shader = twistShader


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process_input(delta):
	pass
func _physics_process(delta):
	process_input(delta)
	if mode == "up":
		look_at(Vector3(Globaldata.playerGPosition.x, Globaldata.playerGPosition.y, Globaldata.playerGPosition.z))
	if mode == "persp":
		look_at(Globaldata.cameraLookAt)
	if mode == "ortho":
		look_at(Globaldata.playerPosition)
	

func _process(delta):
	twistMat.set_shader_parameter("scale", 100 / (twistedTimer.wait_time / twistedTimer.time_left))

func _on_player_to_ortho(dir, o):
	projection = Camera3D.PROJECTION_ORTHOGONAL
	size = 10
	get_node("../").perspMode = "ortho"
	get_node("../").orientation = o
	self.dir = dir


func _on_player_to_perspective():
	projection = Camera3D.PROJECTION_PERSPECTIVE
	get_node("../").perspMode = "persp"


func _on_player_to_up():
	projection = Camera3D.PROJECTION_ORTHOGONAL
	size = 10
	get_node("../").perspMode = "up"


func _on_player_set_shader(shader):
	if shader == "pixel":
		$ShaderPlane.set_surface_override_material(0, pixelMat)
		$ShaderPlane.visible = true
	elif shader == "twist":
		$ShaderPlane.set_surface_override_material(0, twistMat)
		$ShaderPlane.visible = true
		twistMat.set_shader_parameter("scale", 1000)
		twistedTimer.start()
	elif shader == "none":
		$ShaderPlane.visible = false


func _on_twisted_timer_timeout():
	Globaldata.playerPerished = false
	$ShaderPlane.visible = false
