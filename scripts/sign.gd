extends Area3D

signal controls(on)
signal collectibles(on)
signal effects(on)
@export var signType = "controls"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_sign_body_entered(body):
	if body.get_class() == "Player":
		emit_signal(signType, true)


func _on_sign_3_collectibles():
	pass # Replace with function body.


func _on_sign_body_exited(body):
	if body.get_class() == "Player":
		emit_signal(signType, false)
