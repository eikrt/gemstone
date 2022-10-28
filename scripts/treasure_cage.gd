extends Node3D

var opened = false
@export var tokensNeeded = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	if Globaldata.playerTokens >=tokensNeeded && !opened:
		open()
	$NeededLabel.text = "%s" % tokensNeeded
func open():
	$AnimationPlayer.play("New Anim")
	opened = true
	
