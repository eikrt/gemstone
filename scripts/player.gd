extends Entity
class_name Player
@export var orientation = "3d"
signal toOrtho
signal toPerspective
signal toUp
signal setShader(shader)
@onready var blinkSprite = $BlinkNode/BlinkSprite
@onready var currentSprite = get_node("BackSprite")
var itemInVicinity = null
var holdingItem = false
var cameraLookAt = Vector3()
var cameraSetY = 0.0
var projectileScene = load("res://scenes/knife.tscn")
var projectileSpeed = 10
var shootDir = Vector3()
var projectileSpawnPosition = Vector3()
var skills = {"blink": true}
var cannoned = false
var upCannoned = false
var launchSpeed = 100
var orthoDir = "front"
func get_class():
	return "Player"
func shoot():
	var projectile = projectileScene.instantiate()
	projectile.position = $ProjectileSpawnNode.get_global_position()
	projectile.velocity.x = shootDir.x * projectileSpeed
	projectile.velocity.z = shootDir.z * projectileSpeed
	get_tree().root.add_child(projectile)
func handle_input(delta):
		# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		cannoned = false
		upCannoned = false
	# Get the input direction and handle the movement/deceleration.
	var input = Vector3()
	projectileSpawnPosition = $ProjectileSpawnNode.position
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
			if orthoDir == "front":
				input.x += 1
				$BlinkNode.rotation.y = 3.14 / 2
			else:
				input.x += 1
				$BlinkNode.rotation.y = -3.14 / 2
		if orientation == "zlocked":
			if orthoDir == "front":
				input.z -= 1
				$BlinkNode.rotation.y = 0
			else:
				input.z += 1
				$BlinkNode.rotation.y = -3.14 / 2
		if orientation == "xlocked":
			if orthoDir == "front":
				currentSprite.flip_h = true
			else:
				currentSprite.flip_h = true
		if orientation == "zlocked":
			if orthoDir == "front":
				currentSprite.flip_h = true
			else:
				currentSprite.flip_h = false
	if Input.is_action_pressed("d"):
		if orientation == "3d"  || orientation == "up":
			input.x += 1
		if orientation == "xlocked":
			if orthoDir == "front":
				input.x -= 1
				$BlinkNode.rotation.y = -3.14 / 2
			else:
				input.x -= 1
				$BlinkNode.rotation.y = 3.14 / 2
		if orientation == "zlocked":
			if orthoDir == "front":
				input.z += 1
				$BlinkNode.rotation.y = 3.14
			else:
				input.z -= 1
				$BlinkNode.rotation.y = -3.14 / 2
		if orientation == "xlocked":
			if orthoDir == "front":
				currentSprite.flip_h = false
			else:
				currentSprite.flip_h = false
		if orientation == "zlocked":
			if orthoDir == "front":
				currentSprite.flip_h = false
			else:
				currentSprite.flip_h = true
	if Input.is_action_just_pressed("e"):
		if is_on_floor():
			holdingItem = !holdingItem
			if !holdingItem and itemInVicinity:
				itemInVicinity.position = Vector3(position.x, position.y, position.z)
				itemInVicinity.holded = holdingItem
				emit_signal("setShader", "none")
			if cannoned:
				launch()
			if upCannoned:
				up_launch()
	if Input.is_action_just_pressed("c"):
		#shoot()
		pass
		
	if holdingItem and itemInVicinity:
		itemInVicinity.holded = holdingItem
		itemInVicinity.position = Vector3(position.x, position.y + 1, position.z)
		emit_signal("setShader", "pixel")
	cameraLookAt.x = lerp(cameraLookAt.x, position.x, 0.2)
	cameraLookAt.z = lerp(cameraLookAt.z, position.z, 0.2)
	cameraLookAt.y = lerp(cameraLookAt.y + cameraSetY, position.y, 0.2)
	#cameraLookAt.x = position.x
	#cameraLookAt.y = position.y + cameraSetY * 10
	#cameraLookAt.z = position.z
	if Input.is_action_pressed("ui_up"):
		if Globaldata.playerOrientation == "3d":
			if cameraSetY > -2:
				cameraSetY -= delta * 0.3
	if Input.is_action_pressed("ui_down"):
		if Globaldata.playerOrientation == "3d":
			if cameraSetY < 2:
				cameraSetY += delta * 0.3
	input = input.normalized()
	if (velocity.x < -0.1 || velocity.x > 0.1) || (velocity.z < -0.1 || velocity.z > 0.1):
		currentSprite.playing = true
	
	else:
		currentSprite.playing = false
	
	dir = (transform.basis.z * input.z + transform.basis.x * input.x)
	shootDir = (transform.basis.z * -1.0 + transform.basis.x * 0.0)
	var lerpValue = 0.03
	if is_on_floor():
		lerpValue = 0.2
	velocity.x = lerp(velocity.x, dir.x * SPEED, lerpValue)
	velocity.z = lerp(velocity.z, dir.z * SPEED, lerpValue)

	if Input.is_action_pressed("ui_left"):
		if orientation == "3d":
			rotation.y = lerp(rotation.y, rotation.y + 1.0, 0.03)

	if Input.is_action_pressed("ui_right"):
		if orientation == "3d":
			rotation.y = lerp(rotation.y, rotation.y - 1.0, 0.03)
	if Input.is_action_pressed("c"):
		pre_ability("blink")
func launch():
	velocity.x = shootDir.x * launchSpeed
	velocity.z = shootDir.z * launchSpeed
	velocity.y = 10
	cannoned = false
func up_launch():
	velocity.y = launchSpeed
	upCannoned = false
func _input(event):
	if event.is_action_released("c"):
		conduct_ability("blink")
		if skills.has("blink"):
			if $BlinkTimer.is_stopped():
				$BlinkTimer.start()
			blinkSprite.visible = false
func pre_ability(ability):
	if !skills.has(ability):
		return
	if skills[ability]:
		if $BlinkNode/BlinkRayCast.is_colliding():
			blinkSprite.set_global_position($BlinkNode/BlinkRayCast.get_collision_point())
		else:
			blinkSprite.position = Vector3(0,0,-3);
		blinkSprite.visible = true
func conduct_ability(ability):
	if !skills.has(ability):
		return
	if skills[ability]:
		skills[ability] = false
		if ability == "blink":
			blink()
func blink():
	set_global_position(blinkSprite.get_global_position())
func perish():
	position = Globaldata.checkpointPosition
	change_orientation(Globaldata.checkpointOrientation, Globaldata.checkpointDir)
	holdingItem = false
	emit_signal("setShader", "twist")
	Globaldata.playerPerished = true
	velocity = Vector3()
func addSkill(skill):
	skills[skill] = true
func change_orientation(o, dir):
	orientation = o
	orthoDir = dir
	
	if orientation == "xlocked":
		#$Anchor.position = Vector3(0, 2.26, 3.01)
		if orthoDir == "back":
			rotation.y = 0
		elif orthoDir == "front":
			rotation.y = 3.14
	elif orientation == "zlocked":
		#$Anchor.position = Vector3(3.01, 2.26, 0)
		rotation.y = 0
	elif orientation == "up":
		$Anchor.position = Vector3(0, 4, 0)
	else:
		$Anchor.position = Vector3(0, 2.26, 3.01)
	if orientation == "zlocked" || orientation == "xlocked":
		currentSprite.visible = false
		currentSprite = $SideSprite
		currentSprite.visible = true
		emit_signal("toOrtho", dir, o)
		currentSprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		
	elif orientation == "up":
		currentSprite.visible = false
		currentSprite = $UpSprite
		currentSprite.visible = true
		rotation.y = 0
		emit_signal("toUp")

	else:
		$BlinkNode.rotation.y = 0
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
		
	Globaldata.playerOrientation = orientation
	Globaldata.cameraLookAt = cameraLookAt

	move_and_slide()
	



func _process(delta):
	if position.y < -50:
		perish()
func _on_trigger_area_area_entered(area):
	if area.get_class() == "EffectItem":
		itemInVicinity = area
	if area.get_class() == "Cannon":
		cannoned = true
		launchSpeed = area.launchSpeed
	if area.get_class() == "UpCannon":
		upCannoned = true
		launchSpeed = area.launchSpeed
		up_launch()
	if area.get_class() == "Moon":
		Globaldata.playerMoons += 1
		area.queue_free()
		


func _on_trigger_area_body_exited(body):
	pass


func _on_trigger_area_area_exited(area):
	if area.get_class() == "EffectItem":
		itemInVicinity = null

	if area.get_class() == "Checkpoint":
		Globaldata.checkpointPosition = area.position
		Globaldata.checkpointOrientation = area.orientation
	if area.get_class() == "Cannon":
		cannoned = false




func _on_blink_timer_timeout():
	skills["blink"] = true


func _on_trigger_area_body_entered(body):
	if body.get_class() == "Propeller" || body.get_class() == "Harming":
		perish()
