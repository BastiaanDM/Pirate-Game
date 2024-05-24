extends Area2D

@onready var animated_sprite = $"Key Sprite"
signal Key

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	animated_sprite.play("Idle")
	
func _process(_delta):
	if animated_sprite.get_animation() == "Effect" and animated_sprite.frame == 3:
		queue_free()

func _on_body_entered(_body):
	animated_sprite.play("Effect")
	emit_signal("Key")
