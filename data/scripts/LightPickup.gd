extends Area

func _on_Area_body_entered(body):
	$Flashlight.visible = false # hide flashlight prop
	body.has_light = true # give player flashlight
	$"../Teleport2".monitoring = true # enable next ladder teleport


func _on_Teleport_body_entered(body): # triggers when player enters first staircase
	$Flashlight.visible = true
