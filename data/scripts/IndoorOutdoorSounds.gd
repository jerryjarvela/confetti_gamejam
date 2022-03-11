extends Area

func _process(delta):
	if get_overlapping_bodies().size() > 0 :
		$Ambience.bus = "Indoor"
	else :
		$Ambience.bus = "Master"
