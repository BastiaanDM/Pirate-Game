extends Camera2D

@onready var player = get_parent()

@export var follow_x_threshold = 965.5
@export var follow_x_max = 1485
var y_value = 541.5

	

func _process(_delta):
	if player.global_position.x > follow_x_threshold and player.global_position.x < follow_x_max:
		global_position.x = player.global_position.x
	else:
		if player.global_position.x < follow_x_threshold:
			global_position.x = follow_x_threshold
		else:
			global_position.x = follow_x_max
	global_position.y = y_value
