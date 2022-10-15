extends Area3D

@export var orientation_type = "xlocked"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_sider_body_entered(body):

	if body.get_class() == "Player":
		if body.orientation != orientation_type:
			
			body.change_orientation(orientation_type)
		else:
			body.change_orientation("3d")
