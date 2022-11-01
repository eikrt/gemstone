extends CharacterBody3D
class_name Entity

const SPEED = 5.0
const JUMP_VELOCITY = 10.0
var angle = 0.0
var dir

@export var weight: float
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func process_rays(delta):
	if $RayCast3d.is_colliding():
		$BlobShadow.visible = true
		$BlobShadow.set_global_position($RayCast3d.get_collision_point())
		$BlobShadow.position.y += 0.05
		$BlobShadow.position.z += 0.2
		var bscale = abs(1 / (($RayCast3d.get_collision_point().y - get_global_position().y)) * $BlobShadow.size) / 3
		$BlobShadow.scale.x = bscale
		$BlobShadow.scale.y = bscale
	else:
		$BlobShadow.visible = false
func _physics_process(delta):
	process_rays(delta)
	
