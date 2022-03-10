extends KinematicBody

var walk_speed: float = 10
var gravity: float = 1
var jump_velocity: float = 25
var velocity: Vector3
onready var character_sprite: Spatial = $Character
onready var animation_player: AnimationPlayer = $Viewport/Character/AnimationPlayer

func _ready():
	move_lock_z = true
	animation_player.stop()

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
	
	# animation	
	if (Input.get_action_strength("right") - Input.get_action_strength("left") != 0):
		animation_player.play("Walking") # play animation
		character_sprite.flip_h = Input.is_action_pressed("left") # flip the sprite if going left
	else:
		animation_player.stop()
