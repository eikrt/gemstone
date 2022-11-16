extends Area3D


# Called when the node enters the scene tree for the first time.
@export var launchSpeed = 100
@export var active = true
@onready var cannonShader = preload("res://shaders/cannon.gdshader")
var cannonMat = ShaderMaterial.new()
func get_class():
	return "UpCannon"
func _ready():
	cannonMat.shader = cannonShader
	$MeshInstance3d.set_surface_override_material(0, cannonMat)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active:
		cannonMat.set_shader_parameter("c", Color(0,2,0))
		$MeshInstance3d.set_surface_override_material(0, cannonMat)
	else:
		cannonMat.set_shader_parameter("c", Color(1,-1,0))
		$MeshInstance3d.set_surface_override_material(0, cannonMat)

func _on_pedestal_open():
	active = true
