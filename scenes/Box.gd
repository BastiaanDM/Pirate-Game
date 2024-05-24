extends StaticBody2D

@export var hp = 10
@onready var hit_timer = $"Hit Timer"
@onready var death_timer = $"Death Timer"
@onready var sprite = $"Box Sprite"
@onready var area = $"Box Area"

func _ready():
	sprite.play("Idle")
	hit_timer.connect("timeout", Callable(self, "_idle"))
	death_timer.connect("timeout", Callable(self, "_kill"))
	
func _process(_delta):
	var overlaps = area.get_overlapping_areas()
	print(overlaps)
	for areas in overlaps:
		decrement_hp(areas)

func decrement_hp(Area):
	print(Area)
	if !Area.is_in_group("attacks") || !hit_timer.is_stopped() || !death_timer.is_stopped():
		return
	var damage = 5
	hp -= damage
	if hp > 0:
		sprite.play("Hit")
		hit_timer.start()
	else:
		sprite.play("Destroyed")
		death_timer.start()

func _idle():
	sprite.play("Idle")
	hit_timer.stop()
	
func _kill():
	queue_free()
