extends CharacterBody2D

@onready var _animated_sprite = $PlayerSprite

const SPEED = 300.0
const JUMP_VELOCITY = -1200.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
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
		
	elif _animated_sprite.get_animation() == "Jump" or  _animated_sprite.get_animation() == "Fall":
		animation_name = "Land"
	
	
	if animation_name != _animated_sprite.get_animation():
		_animated_sprite.play(animation_name)
	move_and_slide()


