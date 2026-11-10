extends CanvasLayer

@onready var label = $Label

func _process(_delta):
	label.text = "SCORE: " + str(get_parent().score)
