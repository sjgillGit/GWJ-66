extends Resource
class_name PortalsRouter

signal portal_entered(enterence:String, destination:String)


var portal_pairs:Array = [["Farmstead", "Yard"]]
var can_use_portal:bool = true


func move_inside_portal(portal_name:String):
	if !can_use_portal:
		return
	portal_entered.emit(get_opposite_pair(portal_name), portal_name)


func get_opposite_pair(enterence_name:String) -> String:
	for portal_pair in portal_pairs:
		if enterence_name in portal_pair:
			for portal_name in portal_pair:
				if portal_name != enterence_name:
					return portal_name
	return ""
