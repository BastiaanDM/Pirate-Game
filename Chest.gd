extends Area2D

signal Opened
@onready var level = get_parent()
@onready var sprite = $"Chest Sprite"
@onready var timer = $Timer

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	sprite.play("Idle")
	timer.stop()
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))

func _on_body_entered(_body):
	if level.has_key:
		sprite.play("Unlocked")
		timer.start()
		level.has_key = false

func _on_timer_timeout():
	emit_signal("Opened")
