extends CharacterBody2D

@onready var _animated_sprite = $PlayerSprite
@onready var attack_1 = $"Attack 1"
@onready var attack_1_timer = $"Attack 1/Timer"
var attack_1_damage = 0

const SPEED = 300.0
const JUMP_VELOCITY = -1200.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var has_sword = false

func _ready():
	attack_1_timer.connect("timeout", Callable(self, "end_attack"))

func _physics_process(delta):
	
	var current_animation = _animated_sprite.get_animation()
	
	var animation_name
	if not is_on_floor():
		velocity.y += gravity * delta


	var direction = Input.get_axis("Left", "Right")
	if direction:
		velocity.x = direction * SPEED
		animation_name = "Run"
		if direction <0 and _animated_sprite.flip_h == false:
			_animated_sprite.flip_h = true
		if direction >0 and _animated_sprite.flip_h == true:
			_animated_sprite.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animation_name = "Idle"
		
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation_name = "Jump"
		
	if not is_on_floor() :
		if velocity.y>0:
			animation_name = "Fall"
		elif _animated_sprite.frame == 3:
			_animated_sprite.stop()
		else:
			animation_name = "Jump"
		
	elif current_animation == "Jump" or  current_animation == "Fall":
		animation_name = "Land"
		
	if has_sword && is_on_floor() && Input.is_action_just_pressed("Attack 1"):
		attack_1.add_to_group("attacks")
		attack_1_timer.start()
		
	if !attack_1_timer.is_stopped():
		animation_name = "Attack 1"
		
	
	if has_sword and (animation_name == "Fall" or animation_name == "Run" or animation_name == "Jump" or animation_name == "Idle" or animation_name == "Land"):
		animation_name += " Sword"
	
	if (animation_name != current_animation):
		_animated_sprite.play(animation_name)
	move_and_slide()

func end_attack():
	attack_1.remove_from_group("attacks")
	attack_1_timer.stop()
