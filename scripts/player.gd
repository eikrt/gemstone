extends Entity
class_name Player


func handle_input(delta):
		# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	var input = Vector3()
  
	if Input.is_action_pressed("w"):
		input.z -= 1
	if Input.is_action_pressed("s"):
		input.z += 1
	if Input.is_action_pressed("a"):
		input.x -= 1
	if Input.is_action_pressed("d"):
		input.x += 1
	input = input.normalized()
	if (velocity.x < -0.1 || velocity.x > 0.1) || (velocity.z < -0.1 || velocity.z > 0.1):
		$AnimatedSprite3d.playing = true
	else:
		$AnimatedSprite3d.playing = false
	
	var dir = (transform.basis.z * input.z + transform.basis.x * input.x)
	velocity.x = lerp(velocity.x, dir.x * SPEED, 0.2)
	velocity.z = lerp(velocity.z, dir.z * SPEED, 0.2)
	if Input.is_action_pressed("ui_left"):
		rotation.y += 3 * delta
	if Input.is_action_pressed("ui_right"):
		rotation.y -= 3 * delta
	if Input.is_action_pressed("ui_up"):
		pass
	if Input.is_action_pressed("ui_down"):
		pass
func _physics_process(delta):
	# Add the gravity.
	process_rays(delta)
	handle_input(delta)
	Globaldata.playerPosition = position
	if not is_on_floor():
		velocity.y -= weight * gravity * delta


	move_and_slide()
	
