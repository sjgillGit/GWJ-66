extends Control

@onready var quickInventory = $QuickInventory
@onready var Inventory = $Normal
@onready var openQuickButton = $QIbutton

@onready var error = $Normal/Panel/ErrorMessage

var inventoryOpen = false
var quickInventoryOpen = false
#Text Descriptions
@onready var itemDescription = $Normal/Panel/ItemDescription/ItemDescription
@onready var itemName = $Normal/Panel/ItemDescription/ItemName

var dragging = false

var mergingItemSprite = Texture
var mergingItemTag = ""

#Merging Items
var itemOne = ""
var itemTwo = ""
var itemThree = ""
var itemFour = ""

var merged = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	quickInventory.hide()
	Inventory.hide()
	itemName.text = ""
	itemDescription.text = ""
	error.hide()
	
	#Player Starts with these two items
	get_tree().call_group("InventorySpot", "itemGrabbed", "Knife")
	get_tree().call_group("InventorySpot", "itemGrabbed", "Suitcase")
	
	
	
func _process(delta):
	if Input.is_action_just_pressed("OpenInventory") && !GlobalScript.gamePaused:
		if inventoryOpen:
			get_tree().paused = false
			Inventory.hide()
			inventoryOpen = false
		else:
			get_tree().paused = true
			Inventory.show()
			inventoryOpen = true
		
	if GlobalScript.gamePaused:
		Inventory.hide()
		quickInventory.hide()
		inventoryOpen = false
		openQuickButton.hide()
		quickInventoryOpen = false
		
	if inventoryOpen:
		quickInventory.hide()
		openQuickButton.hide()
		quickInventoryOpen = false
	
	if !inventoryOpen && !quickInventoryOpen && !GlobalScript.gamePaused:
		openQuickButton.show()
	else:
		openQuickButton.hide()

func _on_texture_rect_mouse_entered():
	# If mouse touches the show button, show quick inventory
	quickInventory.show()
	quickInventoryOpen = true

func _on_close_quick_inventory_pressed():
	# If close quick button pressed, well, close quick.
	quickInventory.hide()
	quickInventoryOpen = false

func _on_close_inventory_pressed():
	# If close inventory button pressed, well, close inventory.
	get_tree().paused = false
	Inventory.hide()
	inventoryOpen = false

func showDescription(tag,has,used):
	# If the player knows aobut the item (either has it, or used it.)
	if has || used:
		itemName.text = "[center]"+tag+"[/center]"
		
		# HERE ADD THE DESCRIPTIONS FOR EACH ITEM, MAKE SURE THE TAGS MATCH #
		
		if tag == "Knife":
			itemDescription.text = "[center]"+"The knife is a dangerous tool, take your time. Once you use it, there is no going back."+"[/center]"
		elif tag == "Suitcase":
			itemDescription.text = "[center]"+"Holds all of your trusty items, you never know what you might find around here that could help out."+"[/center]"
		elif tag == "Key":
			itemDescription.text = "[center]"+"This Key looks like it might unlock something, could be useful to keep onhand."+"[/center]"
		elif tag == "Wrench":
			itemDescription.text = "[center]"+"A decent tool, maybe there are some other tools you could put with this."+"[/center]"
		elif tag == "Hammer":
			itemDescription.text = "[center]"+"A pretty good tool, maybe there are some other tools you could put with this."+"[/center]"
		elif tag == "Chain Key":
			itemDescription.text = "[center]"+"Another key! but this one looks a bit different, wonder what its for?"+"[/center]"
		elif tag == "Bottle":
			itemDescription.text = "[center]"+"An empty bottle, probably not worth very much."+"[/center]"
		elif tag == "Pill Bottle":
			itemDescription.text = "[center]"+"Looks like a servents pills, they probably wouldn't be very good for you..."+"[/center]"
		elif tag == "Crushed Pills":
			itemDescription.text = "[center]"+"Never really liked swallowing pills very much, but what did these guys do to you?"+"[/center]"
		elif tag == "Acid Bottle":
			itemDescription.text = "[center]"+"The Bottle came in use after all. Now you got some acid! ...What you going to use that for?"+"[/center]"
		elif tag == "Chemical Solution":
			itemDescription.text = "[center]"+"Good job, you've made something, doesn't smell very nice, but maybe it'll come in use?"+"[/center]"
		elif tag == "Muddler":
			itemDescription.text = "[center]"+"Looks like it could be used to crush something, or hit something. Do whatever you like with it."+"[/center]"
		elif tag == "Horse Shoe":
			itemDescription.text = "[center]"+"Looks like a horse forgot one of thier shoes."+"[/center]"
		elif tag == "Tool Box":
			itemDescription.text = "[center]"+"Nice Box to hold your tools, rather then just keeping them in this case."+"[/center]"
		elif tag == "Tool Kit":
			itemDescription.text = "[center]"+"Holds all of of your tools in one organised place."+"[/center]"
			
func hideDescription():
	# set description and name to blank.
	itemName.text = ""
	itemDescription.text = ""

func mergeItems(tag):
	# Set sent tags to three items.
	if merged == 1:
		itemOne = tag
	elif merged == 2:
		itemTwo = tag
	elif merged == 3:
		itemThree = tag
	elif merged == 4:
		itemFour = tag
	merged += 1
	
	mergeRecipees()
	
func _on_merge_button_pressed():
	merged = 1
	get_tree().call_group("MergeItemSlot", "sendMerges")
	get_tree().call_group("MergeItemSlot", "clear")

func mergedItems():
	get_tree().call_group("InventorySpot", "itemUsed", itemOne)
	get_tree().call_group("InventorySpot", "itemUsed", itemTwo)
	get_tree().call_group("InventorySpot", "itemUsed", itemThree)
				
	itemOne = ""
	itemTwo = ""
	itemThree = ""

func mergeRecipees():
	#Go through all the recipees.
	
	var items = [itemOne, itemTwo, itemThree, itemFour]
	
	var createdItem = ""
	
	if "Muddler" in items and "Pill Bottle" in items:
		createdItem = "Crushed Pills"
	elif "Crushed Pills" in items and "Acid Bottle" in items:
		createdItem = "Chemical Substance"
	elif "Hammer" in items and "Wrench" in items and "Tool Box" in items and "Horse Shoe" in items:
		createdItem = "Tool Kit"
		print("worked")
	
	if createdItem != "":
		# Create item.
		get_tree().call_group("InventorySpot", "itemGrabbed", createdItem)
		# Use three items.
		mergedItems()
		error.hide()
	else:
		error.show()

func hideError():
	error.hide()

func _on_panel_mouse_entered():
	GlobalScript.usingQuickInventory = true

func _on_panel_mouse_exited():
	GlobalScript.usingQuickInventory = false

func _on_button_pressed():
	get_tree().call_group("InventorySpot", "itemUsed", "Bottle")
