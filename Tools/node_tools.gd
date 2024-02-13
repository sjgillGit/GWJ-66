extends Node
class_name NodeTools


static func delete_all_children(parent:Node, except:Node=null):
	for node in parent.get_children():
		if node == except:
			continue
		node.queue_free()
