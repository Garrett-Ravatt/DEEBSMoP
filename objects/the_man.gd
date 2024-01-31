extends CharacterBody2D

@export_category("Game Resources")
signal death
signal health_change(int)
@export var health := 3 :
	set(value):
		print("ouchie")
		if value <= 0:
			death.emit()
		health = value
		health_change.emit(health)

signal ammo_change(int)
@export var ammo := 32 :
	set(value):
		if value != ammo:
			ammo = value
			ammo_change.emit(ammo)

signal pri_load_change(int)
@export var pri_load := 4 :
	set(value):
		if value != pri_load:
			pri_load = value
			pri_load_change.emit(pri_load)

signal sec_load_change(int)
@export var sec_load := 4 :
	set(value):
		if value != sec_load:
			sec_load = value
			sec_load_change.emit(sec_load)
			
signal pri_load_max_change(int)
@export var pri_load_max := 4 :
	set(value):
		if value != pri_load:
			pri_load = value
			pri_load_change.emit(pri_load)

signal sec_load_max_change(int)
@export var sec_load_max := 4 :
	set(value):
		if value != sec_load:
			sec_load = value
			sec_load_change.emit(sec_load)

@export_category("Movement")
@export var speed = 600.0 # How fast the player will move (pixels/sec).
@export var accel := 40.0
@export var gun_accel := 1500.0
@export var linear_damping := 0.05
var screen_size # Size of the game window.
#var velocity = Vector2.ZERO # The player's movement vector.

@onready var pri_hitbox : Area2D = $"PrimaryFireHurtbox"
@onready var sec_hitbox : Area2D = $"SecondaryFireHurtbox"

@onready var i_timer : Timer = $"ITimer"
@onready var reload_timer : Timer = $"ReloadTimer"

@onready var front_particles : CPUParticles2D = $"FrontParticles"
@onready var back_particles : CPUParticles2D = $"BackParticles"

func _ready():
	screen_size = get_viewport_rect().size
	#hide()
	

func _process(delta):
	var vect = (get_global_mouse_position() - position).normalized()
	var direction = Vector2(0,0)
	#velocity /= (1.0 + linear_damping * delta)
	if Input.is_action_just_pressed("primary_fire"):
		if pri_load < 1:
			return
		front_particles.emitting = true
		pri_load -= 1
		reload_timer.set_wait_time(1)
		reload_timer.start()
		velocity += -vect * gun_accel
		var emenies := pri_hitbox.get_overlapping_bodies()
		for emeny : RigidBody2D in emenies:
			var to_em := emeny.global_position - global_position
			#TODO: damage
			emeny.health -= 50.0
			#TODO: knockback
			emeny.set_deferred("linear_velocity", to_em.normalized() * gun_accel * 2)
	if Input.is_action_just_pressed("secondary_fire"):
		if sec_load < 1:
			return
		back_particles.emitting = true
		sec_load -= 1
		reload_timer.set_wait_time(1)
		reload_timer.start()
		#velocity += vect * gun_accel*.7
		# NOTE: It's me, Garrett. I did this.
		# NOTE: make the back spread longer and more narrow
		velocity += vect * gun_accel*1.3
		var emenies := sec_hitbox.get_overlapping_bodies()
		for emeny : RigidBody2D in emenies:
			var to_em := emeny.global_position - global_position
			#TODO: damage
			emeny.health -= 25.0
			#TODO: knockback
			emeny.set_deferred("linear_velocity", to_em.normalized() * gun_accel )
			
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

func get_hurt():
	if i_timer.is_stopped():
		health -= 1
		i_timer.start()

func _on_death():
	print("Player freaking died, criminy... H E double hocky sticks dude. Wow.")
	#TODO: Care that the player has died


func _on_reload_timer_timeout():
	if(ammo >0):
		if(sec_load < pri_load && sec_load < sec_load_max):
			sec_load+=1
			ammo-=1
			
		elif(pri_load<pri_load_max):
			pri_load +=1
			ammo-=1
	reload_timer.set_wait_time(.4)
	reload_timer.start()
		
		

func get_ammo():
	ammo += 8
	
func get_health():
	health += 1
	if(health>=3):
		health = 3
