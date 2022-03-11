extends Area

func _on_Area_body_entered(body):
	$Flashlight.visible = false # hide flashlight prop
	body.has_light = true # give player flashlight
	$"../Teleport2".monitoring = true # enable next ladder teleport
