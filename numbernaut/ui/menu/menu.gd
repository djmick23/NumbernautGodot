extends CanvasLayer

@onready var anim = $AnimationPlayer

func _ready():
	get_tree().paused = true

func _process(_delta):
	if anim.current_animation != "start":
		anim.play("bounce")

func _on_button_pressed():
	anim.play("start")

	Sfxlibrary.play("menu")

func start():
	get_tree().paused = false
	queue_free()
