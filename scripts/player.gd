extends Entity
class_name Player
@export var orientation = "3d"
signal toOrtho
signal toPerspective
signal toUp
signal setShader(shader)
signal setSecondaryShader(shader)
const FORWARD_JUMP_SPEED: float = 8.0
const FORWARD_JUMP_SPEED_Y: float = 3.0
const BACKJUMP_SPEED: float = 12.0
@onready var blinkSprite = $BlinkNode/BlinkSprite
@onready var currentSprite = get_node("BackSprite")
@onready var Water = preload("res://scenes/scenery/water.tscn")
var itemInVicinity = null
var holdingItem = false
var cameraLookAt = Vector3()
var cameraSetY = 0.0
var projectileScene = load("res://scenes/knife.tscn")
var projectileSpeed = 10
var shootDir = Vector3()
var projectileSpawnPosition = Vector3()
var skills = {"blink": "locked", "forwardjump": "ready", "backjump": "ready"}
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
func resetStatuses():
	cannoned = false
	upCannoned = false
func jump():
	velocity.y = JUMP_VELOCITY
	resetStatuses()
func handle_input(delta):
		# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		jump()
	# Get the input direction and handle the movement/deceleration.
	var input = Vector3()
	projectileSpawnPosition = $ProjectileSpawnNode.position
	if Input.is_action_pressed("w"):
		if orientation == "3d" || orientation == "up":
			input.z -= 1
		
		if orientation == "3d":
			pass
	if Input.is_action_pressed("s"):
		if orientation == "3d"  || orientation == "up":
			input.z += 1
		if orientation == "3d":
			pass
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
				pass
			else:
				pass
		if orientation == "zlocked":
			if orthoDir == "front":
				pass
			else:
				pass
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
				pass
			else:
				pass
		if orientation == "zlocked":
			if orthoDir == "front":
				pass
			else:
				pass
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
		pass
	
	else:
		pass
	
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

	if Input.is_action_pressed("w"):
		if Input.is_action_just_pressed("c"):
			if skills["forwardjump"] == "ready":
				if $ForwardjumpTimer.is_stopped():
					$ForwardjumpTimer.start()
				conduct_ability("forwardjump")
	if Input.is_action_pressed("s"):
		if Input.is_action_just_pressed("c"):
			if skills["backjump"] == "ready":
				if $BackjumpTimer.is_stopped():
					$BackjumpTimer.start()
				conduct_ability("backjump")
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
		pass
		#conduct_ability("blink")
		#if skills.has("blink"):
		#	if $BlinkTimer.is_stopped():
		#		$BlinkTimer.start()
		#	blinkSprite.visible = false
	
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
		skills[ability] = "notready"
		if ability == "blink":
			blink()
		if ability == "forwardjump":
			forwardjump()
		if ability == "backjump":
			backjump()
func backjump():
	velocity.y += BACKJUMP_SPEED
func forwardjump():

	velocity.x += shootDir.x * FORWARD_JUMP_SPEED
	velocity.z += shootDir.z * FORWARD_JUMP_SPEED
	velocity.y += FORWARD_JUMP_SPEED_Y
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
	skills[skill] = "ready"
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
		pass
		emit_signal("toOrtho", dir, o)
		currentSprite.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		
	elif orientation == "up":
		pass
		rotation.y = 0
		emit_signal("toUp")

	else:
		$BlinkNode.rotation.y = 0
		pass
		emit_signal("toPerspective")
	if orientation == "up":
		pass
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
	for skill in skills:
		if skills[skill] == "pending":
			if is_on_floor():
				skills[skill] = "ready"
	if position.y < -150:
		pass
		#perish()
func _on_trigger_area_area_entered(area):
	if area.get_class() == "Harming":
		perish()
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
	if area.get_class() == "Water":
		if (area as Water).toxic:
			perish()
		else:
			emit_signal("setSecondaryShader", "underWater")
	if area.get_class() == "Shard":
		Globaldata.playerShards += 1
		if Globaldata.playerShards >= 10:
			Globaldata.playerTokens += 1
			Globaldata.playerShards = 0
		area.queue_free()
	if area.get_class() == "Token":
		Globaldata.playerTokens += 1
		area.queue_free()
	if area.get_class() == "Moon":
		Globaldata.playerMoons += 1
		area.queue_free()
	if area.get_class() == "Gem":
		Globaldata.playerGems += 1
		area.queue_free()
	if area.get_class() == "Port":
		set_global_position(area.get_node("Target").get_global_position())
	
	
		


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
	if area.get_class() == "Water":
		emit_signal("setSecondaryShader", "exitedUnderWater")




func _on_blink_timer_timeout():
	skills["blink"] = "ready"


func _on_trigger_area_body_entered(body):
	if body.get_class() == "Propeller" || body.get_class() == "Harming":
		perish()


func _on_forwardjump_timer_timeout():
	skills["forwardjump"] = "pending"


func _on_backjump_timer_timeout():
	skills["backjump"] = "pending"
