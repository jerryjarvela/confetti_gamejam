extends KinematicBody

var walk_speed: float = 10
var gravity: float = 1
var jump_velocity: float = 25
var velocity: Vector3
onready var character_sprite: Spatial = $Character
onready var animation_player: AnimationPlayer = $Viewport/Character/AnimationPlayer
onready var FLAG = false
#the flag-true var

func _ready():
	$Sprite3D.visible = false
	$Sprite3D2.visible = false
	move_lock_z = true
	animation_player.stop()


func _physics_process(delta):
	Use_Flag()
	Disable_Flag()
	



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
		if (Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right")):
			animation_player.stop() # two prevent blending
			pass
		animation_player.play("Walking") # play animation
		character_sprite.flip_h = Input.is_action_pressed("left") # flip the sprite if going left
	else:
		print(animation_player.get_default_blend_time())
		animation_player.play("Idle")


func _on_FlagArea_area_entered(area):
	if FLAG != true:
		if area.is_in_group("Enemy"):
			print(FLAG)
			$Sprite3D.visible = true
			print("GET.WRECKED.")
			#$Detection_Timer.start()
		



func _on_Detection_Timer_timeout():
	$Sprite3D.visible = true #YOU SHOULD BE DEAD NOW.
	

func _on_FlagArea_area_exited(area):
		print("safe")
		$Sprite3D.visible = false



func Use_Flag():
	if Input.is_action_pressed("Click"):
		print(FLAG)
		var FLAG = true
		$Pivot/Camera/SpotLight.light_energy = 20
		$Pivot/Camera/SpotLight.spot_angle = 6
		$Flashlight.visible = false
		$Sprite3D2.visible = true
		


func Disable_Flag():
	if Input.is_action_just_released("Click"):
		var FLAG = false
		$Pivot/Camera/SpotLight.light_energy = 10
		$Pivot/Camera/SpotLight.spot_angle = 2.99
		$Flashlight.visible = true
		$Sprite3D2.visible = false
