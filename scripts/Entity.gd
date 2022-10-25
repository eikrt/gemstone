extends CharacterBody3D
class_name Entity

const SPEED = 5.0
const JUMP_VELOCITY = 10.0
var angle = 0.0
@onready var currentSprite = get_node("BackSprite")
@export var weight: float
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func process_rays(delta):
	if $RayCast3d.is_colliding():
		$BlobShadow.visible = true
		$BlobShadow.set_global_position($RayCast3d.get_collision_point())
		$BlobShadow.position.y += 0.2
		$BlobShadow.position.z += 0.2
		var bscale = 1 /( (position.y + currentSprite.scale.y - $BlobShadow.position.y) / 6) 
		$BlobShadow.scale.x = bscale
		$BlobShadow.scale.y = bscale
	else:
		$BlobShadow.visible = false
func _physics_process(delta):
	# Add the gravity.
	process_rays(delta)

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	var input = Vector3()
  
	input = input.normalized()
	if (velocity.x < -0.1 || velocity.x > 0.1) || (velocity.z < -0.1 || velocity.z > 0.1):
		$AnimatedSprite3d.playing = true
	else:
		$AnimatedSprite3d.playing = false
	
	var dir = (transform.basis.z * input.z + transform.basis.x * input.x)

	move_and_slide()
	
