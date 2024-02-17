extends Area3D


@export var portals_router:PortalsRouter
var can_use_this_portal:bool = true

func _on_body_entered(body):
	if !portals_router.can_use_portal or !can_use_this_portal:
		return
	portals_router.move_inside_portal(name)
	portals_router.can_use_portal = false
	Main.portal_timer.start(1)
	can_use_this_portal = false



