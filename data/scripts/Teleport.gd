extends Area

func _on_Teleport_body_entered(body):
	body.global_transform.origin = $Exit.global_transform.origin
