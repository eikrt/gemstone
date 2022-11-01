extends Area3D

@export var triggeredByMoons = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	if triggeredByMoons:
		visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globaldata.playerMoons > 0:
		visible = true

func _on_token_body_entered(body):
	if body.get_class() == "Player" && visible:
		Globaldata.playerTokens += 1
		queue_free()
