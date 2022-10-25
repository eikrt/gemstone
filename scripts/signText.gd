extends Node2D

@export var textType = "controls"
# Called when the node enters the scene tree for the first time.
func _ready():
	match textType:
		"controls":
			$Title.text = "Controls"
			$Body.text = "Move with wasd, rotate camera with arrows and jump with space!"
		"effects":
			$Title.text = "Items"
			$Body.text = "You can find lots of peculiar items laying around. Maybe they can be useful? Try picking one up with E button. They seem to have serious side effects."
		"collectibles":
			$Title.text = "Collectibles"
			$Body.text = "You can find two types of collectibles lying around: gems and tokens!"
		
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_sign_effects(on):
	visible = on


func _on_sign_2_controls(on):
	visible = on


func _on_sign_3_collectibles(on):
	visible = on

