extends Node3D

var ball = preload("res://scenes/harming_ball.tscn")
@export var expireTime = 8
@export var wait_t = 2
@export var randRange = 4
@export var vel = Vector3(0,0,10)
# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnTimer.wait_time = wait_t + randf_range(0,randRange)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_timer_timeout():
	
	var ball_instance = ball.instantiate()
	ball_instance.set_name("ball")
	ball_instance.velocity = vel
	ball_instance.get_node("ExpireTimer").wait_time = expireTime
	add_child(ball_instance)
