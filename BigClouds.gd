extends Node

var children

# Called when the node enters the scene tree for the first time.
func _ready():
	children = get_children()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	for child in children:
		child.global_position.x -= 100 * delta
		if child.global_position.x < -1290.5:
			child.global_position.x += 2*2688
		child.global_position.x = round(child.global_position.x)
			
		
