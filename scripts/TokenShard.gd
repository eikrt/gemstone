extends Area3D
# Called when the node enters the scene tree for the first time.
func _get_class():
	return "Shard"
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Globaldata.playerMoons > 0:
		visible = true

func _on_token_body_entered(body):
	pass
