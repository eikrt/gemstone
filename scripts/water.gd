extends Area3D

class_name Water
# Called when the node enters the scene tree for the first time.
@export var toxic = true
@onready var toxicShader = preload("res://shaders/toxic_water.gdshader")
@onready var normalShader = preload("res://shaders/normal_water.gdshader")
@onready var toxicNormalmap = preload("res://res/textures/Ice003_1K-PNG/Ice003_1K_Color.png")
@onready var toxicTex = preload("res://res/textures/SurfaceImperfections011_2K-PNG/SurfaceImperfections011_2K_var1.png")
var toxicMat = ShaderMaterial.new()
var normalMat = ShaderMaterial.new()
@onready var twistedTimer = get_node("TwistedTimer")
func _get_class():
	return "Water"
func _ready():
	toxicMat.shader = toxicShader
	normalMat.shader = normalShader
	toxicMat.set_shader_parameter("tex", toxicTex)
	toxicMat.set_shader_parameter("normalmap", toxicNormalmap)
	changeState("toxic")
func changeState(state):
	if state == "toxic":
		$MeshInstance3d.set_surface_override_material(0, toxicMat)
		
	else:
		$MeshInstance3d.set_surface_override_material(0, normalMat)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if toxic:
#		$MeshInstance3d.set_surface_override_material(0, toxicMat)
#	else:
#		$MeshInstance3d.set_surface_override_material(0, normalMat)
