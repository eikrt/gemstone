extends StaticBody3D

signal open
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_area_entered(area):
	if area.get_class() == "EffectItem":
		area.queue_free()
		emit_signal("open")
		
