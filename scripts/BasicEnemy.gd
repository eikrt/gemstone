extends CharacterBody3D


const SPEED = 10.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func get_class():
	return "BasicEnemy"
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()
func _process(delta):
	var distToPlayer = position.distance_to(Globaldata.playerGPosition)
	if distToPlayer < 5.0:
		var angleToPlayer = atan2(Globaldata.playerGPosition.x - position.x, Globaldata.playerGPosition.z - position.z)
		velocity.x = sin(angleToPlayer) * (SPEED * delta) * 10
		velocity.z = cos(angleToPlayer) * (SPEED * delta) * 10
