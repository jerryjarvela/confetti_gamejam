extends Spatial

func _ready():
	pass

func _process(delta):
	var cursor_pos_viewport: Vector2 = - get_viewport().get_mouse_position()
	var flashlight_pos_viewport: Vector2 = - get_viewport().get_camera().unproject_position(global_transform.origin)
	var light_direction_2d: Vector2 = cursor_pos_viewport - flashlight_pos_viewport
	var light_direction: Vector3 = Vector3(-light_direction_2d.x, light_direction_2d.y, 0)
	if light_direction.x > 0 : look_at(light_direction, Vector3.UP)
	else: look_at(light_direction, Vector3.DOWN) # Light is not visible without this when x > 0. I have no idea why.

func _input(event):
	pass
