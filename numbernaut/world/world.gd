extends Node2D

@onready var nn = $numbernaut

var cloud = preload("res://clouds/cloud.tscn")

var interval = 120
var next = 0
var score = 0
var base_score = 0

func _ready() -> void:
	next = nn.global_position.y + 50

func _physics_process(_delta: float) -> void:
	#delete clouds
	for child in get_children():
		if child.is_in_group("cloud") && (nn.global_position.y - child.global_position.y) > 320:
			child.queue_free()
	
	#add clouds
	if nn.global_position.y + 320 > next:
		spawn_cloud(next)
		next += interval
		
		if score < 500:
			interval = randi_range(30, 60)
		else:
			interval = randi_range(50, 80)
	
	#score
	score = base_score + int(nn.global_position.y / 10)

func spawn_cloud(y_pos):
	var cloud_instance = cloud.instantiate()
	cloud_instance.global_position = Vector2(randi_range(10, 90), y_pos)
	call_deferred("add_child", cloud_instance)
