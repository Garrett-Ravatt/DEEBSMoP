extends CharacterBody2D

signal death
@export var health := 100.0 :
	set(value):
		if value <= 0:
			death.emit()
		health = value

@export var speed = 600.0 # How fast the player will move (pixels/sec).
@export var accel := 40.0
@export var gun_accel := 1500.0
@export var linear_damping := 0.05
var screen_size # Size of the game window.
#var velocity = Vector2.ZERO # The player's movement vector.

func _ready():
	screen_size = get_viewport_rect().size
	#hide()
	

func _process(delta):
	var vect = (get_global_mouse_position() - position).normalized()
	var direction = Vector2(0,0)
	#velocity /= (1.0 + linear_damping * delta)
	if Input.is_action_just_pressed("primary_fire"):
		velocity += -vect * gun_accel
	if Input.is_action_just_pressed("secondary_fire"):
		#velocity += vect * gun_accel*.7
		# NOTE: It's me, Garrett. I did this.
		velocity += vect * gun_accel*1.3
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_down"):
		direction.y += 1
	if Input.is_action_pressed("move_up"):
		direction.y -= 1
	#if velocity.length() > 0:
		#velocity = velocity.normalized() * speed
	
	#position += velocity * delta
	#velocity.limit_length(speed)
	if direction != Vector2(0,0) and (direction.dot(velocity) < 0 or velocity.length() < speed):
		velocity += direction * accel 
		velocity = velocity.limit_length(speed)

	#print(velocity.length())
	velocity = velocity.limit_length(velocity.length() / (1.0 + linear_damping))
	
	position = position.clamp(Vector2.ZERO, screen_size)
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	
	move_and_slide()
