extends StaticBody3D


# Called when the node enters the scene tree for the first time.
var emerged = false
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globaldata.playerFeathers > 3 && not emerged:
		emerge()
func emerge():
	emerged = true
	$AnimationPlayer.play("New Anim")
