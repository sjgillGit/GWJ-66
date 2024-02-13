extends Control


func _on_use_pressed():
	get_tree().call_group("QuickInventorySpot", "itemUsed", "key")

func _on_pick_pressed():
	get_tree().call_group("QuickInventorySpot", "itemGrabbed", "key")

func _on_use_2_pressed():
	get_tree().call_group("QuickInventorySpot", "itemUsed", "banana")

func _on_pick_2_pressed():
	get_tree().call_group("QuickInventorySpot", "itemGrabbed", "banana")

