extends Area3D

@export var triggeredByMoons = false
# Called when the node enters the scene tree for the first time.
func _get_class():
	return "Token"
func _ready():
	pass # Replace with function body.
	if triggeredByMoons:
		visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globaldata.playerMoons > 0:
		visible = true
