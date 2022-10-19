extends Node3D


# Called when the node enters the scene tree for the first time.
@export var openState = true
func _ready():
	pass # Replace with function body.
	$Bridge/AnimationPlayer.play("New Anim")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func open():
	openState = true
	$Bridge/AnimationPlayer.play_backwards("New Anim")
func close():
	openState = false
	$Bridge/AnimationPlayer.play("New Anim")
	


func _on_pedestal_open():
	open()
