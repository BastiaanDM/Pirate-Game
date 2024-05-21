extends Sprite2D

@onready var children = get_children()

func _ready():
	for child in children:
		if child is AnimatedSprite2D:
			child.play("default")
