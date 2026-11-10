extends Area2D

@onready var sprite = $Sprite2D

var number = 0

func _ready() -> void:
	randomize()
	number = randi_range(1, 5)
	sprite.frame = number - 1

func _on_body_entered(body: Node2D) -> void:
	if body.number == number:
		body.jump()
	else:
		body.hurt()
	
	queue_free()
