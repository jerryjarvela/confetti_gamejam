extends Area

func _on_Area_body_entered(body):
	$Flag.visible = false # hide flag
	body.has_flag = true # give player flag
