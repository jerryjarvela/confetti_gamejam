extends KinematicBody

var walk_speed: float = 10
var gravity: float = 1
var jump_velocity: float = 25
var velocity: Vector3

func _ready():
	move_lock_z = true

func _process(delta):
	var direction: Vector3 = Vector3.ZERO;
	velocity.x = walk_speed * (Input.get_action_strength("right") - Input.get_action_strength("left"))
	if Input.is_action_just_pressed("jump") : velocity.y = jump_velocity
	if (is_on_floor()):
		print("on floor")
	else:
		velocity.y -= gravity
	velocity = move_and_slide(velocity)
	velocity.z = 0
