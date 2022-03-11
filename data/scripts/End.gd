extends Area

func _on_Area_body_entered(body):
	var err = get_tree().reload_current_scene() # restarts scene
	if err: print("Scene reload error: " + err)
