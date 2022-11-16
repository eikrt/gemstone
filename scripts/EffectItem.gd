extends Area3D


# Called when the node enters the scene tree for the first time.
var holded = false
@onready var initialPos = get_global_position()
@export var effectName = "pixel"
func get_class():
	return "EffectItem"
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$BlobShadow.visible = !holded
	if Globaldata.playerPerished:
		holded = false
		set_global_position(Vector3(initialPos.x, initialPos.y, initialPos.z))
