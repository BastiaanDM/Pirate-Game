extends Area2D

@onready var animated_sprite = $"Sword Sprite"
signal Obtained_Sword

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	animated_sprite.play("Idle")
	
func _on_body_entered(_body):
	emit_signal("Obtained_Sword")
	queue_free()

func appear():
	set_monitoring(true)
	show()
