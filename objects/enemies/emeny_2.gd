extends CharacterBody2D

signal death
@export var health := 100.0 :
	set(value):
		if value <= 0:
			death.emit()
		health = value

@export var speed := 150.0
@export var accel := 100.0

enum EMENYSTATE {
	PURSUIT,
	PATROL,
}
var _state : EMENYSTATE = EMENYSTATE.PATROL :
	set(value):
		if _state == value:
			return

		# TEARDOWN
		match _state:
			EMENYSTATE.PATROL:
				print("leaving Patrol")
			EMENYSTATE.PURSUIT:
				target = null

		# BUILD
		match value:
			EMENYSTATE.PURSUIT:
				var new_target = get_tree().get_first_node_in_group("aggro_target")
				if new_target != null:
					target = new_target
				else:
					push_warning("PURSUIT state change aborted because Emeny Two cannot find a target")
					return

		_state = value

var target : Node2D = null

func _ready():
	_state = EMENYSTATE.PURSUIT

func _physics_process(delta):
	match _state:
		EMENYSTATE.PATROL:
			pass
		EMENYSTATE.PURSUIT:
			var direction = (target.global_position - global_position).normalized()
			
			if direction:
				velocity.x = clamp(velocity.x + direction.x * accel * delta, -speed, speed)
				velocity.y = clamp(velocity.y + direction.y * accel * delta, -speed, speed)
			else:
				velocity.x = move_toward(velocity.x, 0, speed * delta)

	move_and_slide()
