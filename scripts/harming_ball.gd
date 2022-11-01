extends Entity
@export var vel = Vector3()

func _ready():
	#velocity = vel
	pass
func get_class(): 
	return "Harming"
func _physics_process(delta):
	# Add the gravity.
	process_rays(delta)
	
	if not is_on_floor():
		#velocity.y -= weight * gravity * delta
		pass
	move_and_slide()


func _on_expire_timer_timeout():
	queue_free()
