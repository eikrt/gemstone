extends SpringArm3D

var mode = "persp"
var dir = "front"
var perspMode = "3d"
var orientation = "xlocked"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _physics_process(delta):
	#self.position.x = lerp(position.x, Globaldata.cameraTargetPosition.x, 0.08)
	#self.position.y = lerp(position.y, Globaldata.cameraTargetPosition.y, 0.2)
	#self.position.z = lerp(position.z, Globaldata.cameraTargetPosition.z, 0.08)
	if perspMode == "up":
		#position = Vector3(Globaldata.playerPosition.x, Globaldata.playerPosition.y + 10, Globaldata.playerPosition.z + 0.1)
		set_global_position(Vector3(Globaldata.playerGPosition.x, Globaldata.playerGPosition.y + 10, Globaldata.playerGPosition.z))
	elif perspMode == "ortho":
		position.y = Globaldata.playerPosition.y
		if dir == "front":
			if orientation == "xlocked":
				set_global_position(Vector3(Globaldata.playerGPosition.x - 10, Globaldata.playerGPosition.y , Globaldata.playerGPosition.z + 10))
			elif orientation == "zlocked":
				set_global_position(Vector3(Globaldata.playerGPosition.x - 10, Globaldata.playerGPosition.y, Globaldata.playerGPosition.z - 3))
		elif dir == "back":
			if orientation == "xlocked":
				set_global_position(Vector3(Globaldata.playerGPosition.x, Globaldata.playerGPosition.y, Globaldata.playerGPosition.z + 3))
			elif orientation == "zlocked":
				set_global_position(Vector3(Globaldata.playerGPosition.x + 3, Globaldata.playerGPosition.y, Globaldata.playerGPosition.z))
	elif mode == "persp":
		set_global_position(Vector3(Globaldata.playerGPosition.x, Globaldata.playerGPosition.y + 1, Globaldata.playerGPosition.z))

