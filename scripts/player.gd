extends Entity
class_name Player
@export var orientation = "3d"
signal toOrtho
signal toPerspective
signal toUp
var itemInVicinity = null
var holdingItem = false
func get_class():
	return "Player"
func handle_input(delta):
		# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	var input = Vector3()
  
	if Input.is_action_pressed("w"):
		if orientation == "3d" || orientation == "up":
			input.z -= 1
		
		if orientation == "3d":
			currentSprite.visible = false
			currentSprite = $BackSprite
			currentSprite.visible = true
	if Input.is_action_pressed("s"):
		if orientation == "3d"  || orientation == "up":
			input.z += 1
		if orientation == "3d":
			currentSprite.visible = false
			currentSprite = $FrontSprite
			currentSprite.visible = true
	if Input.is_action_pressed("a"):
		if orientation == "3d"  || orientation == "up" :
			input.x -= 1
		if orientation == "xlocked":
			input.x -= 1
		if orientation == "zlocked":
			input.z += 1
		if orientation == "zlocked" || orientation == "xlocked":
			currentSprite.flip_h = true
	if Input.is_action_pressed("d"):
		if orientation == "3d"  || orientation == "up":
			input.x += 1
		if orientation == "xlocked":
			input.x += 1
		if orientation == "zlocked":
			input.z -= 1
		if orientation == "zlocked" || orientation == "xlocked":
			currentSprite.flip_h = false
	if Input.is_action_just_pressed("e"):
		holdingItem = !holdingItem
		if !holdingItem:
			itemInVicinity.position = Vector3(position.x, position.y, position.z)
			itemInVicinity.holded = holdingItem
	if holdingItem:
		itemInVicinity.holded = holdingItem
		itemInVicinity.position = Vector3(position.x, position.y + 1, position.z)
	
	input = input.normalized()
	if (velocity.x < -0.1 || velocity.x > 0.1) || (velocity.z < -0.1 || velocity.z > 0.1):
		currentSprite.playing = true
	
	else:
		currentSprite.playing = false
	
	var dir = (transform.basis.z * input.z + transform.basis.x * input.x)
	var lerpValue = 0.03
	if is_on_floor():
		lerpValue = 0.2
	velocity.x = lerp(velocity.x, dir.x * SPEED, lerpValue)
	velocity.z = lerp(velocity.z, dir.z * SPEED, lerpValue)
	if Input.is_action_pressed("ui_left"):
		if orientation == "3d":
			rotation.y += 3 * delta

	if Input.is_action_pressed("ui_right"):
		if orientation == "3d":
			rotation.y -= 3 * delta

	if Input.is_action_pressed("ui_up"):
		pass
	if Input.is_action_pressed("ui_down"):
		pass
		
func change_orientation(o):
	orientation = o
	if orientation == "xlocked":
		$Anchor.position = Vector3(0, 2.26, 3.01)
		rotation.y = 0
	elif orientation == "zlocked":
		$Anchor.position = Vector3(3.01, 2.26, 0)
		rotation.y = 0
	elif orientation == "up":
		$Anchor.position = Vector3(0, 4, 0)
	else:
		$Anchor.position = Vector3(0, 2.26, 3.01)
	if orientation == "zlocked" || orientation == "xlocked":
		currentSprite.visible = false
		currentSprite = $SideSprite
		currentSprite.visible = true
		emit_signal("toOrtho")
		currentSprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		
	elif orientation == "up":
		currentSprite.visible = false
		currentSprite = $UpSprite
		currentSprite.visible = true
		rotation.y = 0
		emit_signal("toUp")

	else:
		currentSprite.visible = false
		currentSprite = $BackSprite
		currentSprite.visible = true
		currentSprite.billboard = BaseMaterial3D.BILLBOARD_FIXED_Y
		emit_signal("toPerspective")
	if orientation == "up":
		currentSprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
func _physics_process(delta):
	# Add the gravity.
	process_rays(delta)
	handle_input(delta)

	Globaldata.playerPosition = position
	Globaldata.playerGPosition = get_global_position()
	if not is_on_floor():
		velocity.y -= weight * gravity * delta


	move_and_slide()
	




func _on_trigger_area_area_entered(area):
	if area.get_class() == "EffectItem":
		itemInVicinity = area
