extends Node
class_name NodeTools


static func delete_all_children(parent:Node):
	for node in parent.get_children():
		node.queue_free()
