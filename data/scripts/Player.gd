extends KinematicBody

export var walk_speed: float
export var gravity: float
export var jump_velocity: float
var velocity: Vector3
export var has_flag: bool
export var has_light: bool
onready var character_sprite: Spatial = $Character
onready var animation_player: AnimationPlayer = $Viewport/Character/AnimationPlayer
var flag = false
#the flag-true var

func _ready():
	$Redflag.visible = false
	$Whiteflag.visible = false
	move_lock_z = true
	animation_player.stop()

func _physics_process(delta):
	pass
	#Use_Flag()
	#Disable_Flag()

func _process(delta):
	# controls for quitting and restarting the game
	if (Input.is_action_just_pressed("ui_cancel")):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().quit()
	if (Input.is_action_just_pressed("restart")):
		var err = get_tree().reload_current_scene()
		if err: print("Scene reload error: " + err)
	
	# walking controls
	var direction: Vector3 = Vector3.ZERO;
	velocity.x = walk_speed * (Input.get_action_strength("right") - Input.get_action_strength("left"))
	
	
	# jumping
	if (is_on_floor()):
		# is_on_floor() is not reliable, so can't use is_action_just_pressed() here
		if Input.is_action_pressed("jump") : velocity.y = jump_velocity
	else: #gravity
		velocity.y -= gravity
	velocity = move_and_slide(velocity, Vector3.UP)
	velocity.z = 0
	
	# animation	
	if (Input.get_action_strength("right") - Input.get_action_strength("left") != 0):
		if (Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right")):
			animation_player.stop() # to prevent animation blending, or whatever is causing the animations to be too slow
			$Footsteps.play() # sound
		animation_player.play("Walking") # play animation
		character_sprite.flip_h = Input.is_action_pressed("left") # flip the sprite if going left
		$Whiteflag.flip_h = Input.is_action_pressed("right") # ...and flag
	else:
		animation_player.play("Idle")
		$Footsteps.stop() # sound
		
	# light/flag
	if Input.is_action_just_pressed("light"):
		if has_light:
			$Whiteflag.visible = false
			$Flashlight.visible = !$Flashlight.visible
			if $Whiteflag.visible : $Pivot/Camera/SpotLight.spot_angle = 6
			else : $Pivot/Camera/SpotLight.spot_angle = 4
		
	if Input.is_action_just_pressed("flag"):
		if has_flag:
			$Whiteflag.visible = !$Whiteflag.visible
			$Flashlight.visible = false
			if $Whiteflag.visible : $Pivot/Camera/SpotLight.spot_angle = 6
			else : $Pivot/Camera/SpotLight.spot_angle = 4

func _on_FlagArea_area_entered(area):
	if flag != true:
		if area.is_in_group("Enemy"):
			#print(FLAG)
			$Redflag.visible = true
			#print("GET.WRECKED.")
			#$Detection_Timer.start()

func _on_Detection_Timer_timeout():
	$Redflag.visible = true #YOU SHOULD BE DEAD NOW.

func _on_FlagArea_area_exited(area):
	#print("safe")
	$Redflag.visible = false

func Use_Flag():
	#var FLAG = true
	#$Pivot/Camera/SpotLight.light_energy = 20
	#$Pivot/Camera/SpotLight.spot_angle = 6
	#$Redflag.visible = false
	$Whiteflag.visible = true

func Disable_Flag():
	#var FLAG = false
	#$Pivot/Camera/SpotLight.light_energy = 10
	#$Pivot/Camera/SpotLight.spot_angle = 2.99
	#$Flashlight.visible = true
	$Whiteflag.visible = false


func _on_Teleport2_body_entered(body):
	$Pivot/Camera.size = 15
