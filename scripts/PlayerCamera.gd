extends Camera3D


# Called when the node enters the scene tree for the first time.
var mode = "persp"
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.position.x = lerp(position.x, Globaldata.cameraTargetPosition.x, 0.1)
	self.position.y = lerp(position.y, Globaldata.cameraTargetPosition.y, 0.1)
	self.position.z = lerp(position.z, Globaldata.cameraTargetPosition.z, 0.1)
	if mode == "up":
		position = Vector3(Globaldata.playerPosition.x, Globaldata.playerPosition.y + 10, Globaldata.playerPosition.z + 0.1)
		look_at(Vector3(Globaldata.playerGPosition.x, Globaldata.playerGPosition.y, Globaldata.playerGPosition.z))
	if mode == "ortho":
		position.y = Globaldata.playerPosition.y
	if mode == "ortho" || mode == "persp":
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
