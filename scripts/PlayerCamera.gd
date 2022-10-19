extends Camera3D


# Called when the node enters the scene tree for the first time.
var mode = "persp"
@onready var pixelShader = preload("res://shaders/pixelated.gdshader")
var pixelMat = ShaderMaterial.new()

func _ready():
	pixelMat.shader = pixelShader


# Called every frame. 'delta' is the elapsed time since the previous frame.
func process_input(delta):
	pass
func _physics_process(delta):
	process_input(delta)
	self.position.x = lerp(position.x, Globaldata.cameraTargetPosition.x, 0.08)
	self.position.y = lerp(position.y, Globaldata.cameraTargetPosition.y, 0.08)
	self.position.z = lerp(position.z, Globaldata.cameraTargetPosition.z, 0.08)
	if mode == "up":
		position = Vector3(Globaldata.playerPosition.x, Globaldata.playerPosition.y + 10, Globaldata.playerPosition.z + 0.1)
		look_at(Vector3(Globaldata.playerGPosition.x, Globaldata.playerGPosition.y, Globaldata.playerGPosition.z))
	if mode == "ortho":
		position.y = Globaldata.playerPosition.y
	if mode == "persp":
		look_at(Globaldata.cameraLookAt)
	if mode == "ortho":
		look_at(Globaldata.playerPosition)
	


func _on_player_to_ortho():
	projection = Camera3D.PROJECTION_ORTHOGONAL
	size = 10
	mode = "ortho"


func _on_player_to_perspective():
	projection = Camera3D.PROJECTION_PERSPECTIVE
	mode = "persp"


func _on_player_to_up():
	projection = Camera3D.PROJECTION_ORTHOGONAL
	size = 10
	mode = "up"


func _on_player_set_shader(shader):
	if shader == "pixel":
		$ShaderPlane.set_surface_override_material(0, pixelMat)
		$ShaderPlane.visible = true
	if shader == "none":
		$ShaderPlane.visible = false
