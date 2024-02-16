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

var merged = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	quickInventory.hide()
	Inventory.hide()
	itemName.text = ""
	itemDescription.text = ""
	error.hide()
	
	get_tree().call_group("InventorySpot", "itemGrabbed", "banana")
	get_tree().call_group("InventorySpot", "itemGrabbed", "key")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("OpenInventory"):
		if inventoryOpen:
			Inventory.hide()
			inventoryOpen = false
		else:
			Inventory.show()
			inventoryOpen = true
		
	if inventoryOpen:
		quickInventory.hide()
		openQuickButton.hide()
		quickInventoryOpen = false
	
	if !inventoryOpen && !quickInventoryOpen:
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
	Inventory.hide()
	inventoryOpen = false

func showDescription(tag,has,used):
	# If the player knows aobut the item (either has it, or used it.)
	if has || used:
		itemName.text = "[center]"+tag+"[/center]"
		
		# HERE ADD THE DESCRIPTIONS FOR EACH ITEM, MAKE SURE THE TAGS MATCH #
		
		if tag == "banana":
			itemDescription.text = "[center]"+"The banana is a berry."+"[/center]"
		elif tag == "key":
			itemDescription.text = "[center]"+"The Key can be used to unlock something"+"[/center]"
		elif tag == "snowball":
			itemDescription.text = "[center]"+"The Snowball is a little cold"+"[/center]"
		elif tag == "Super Banana":
			itemDescription.text = "[center]"+"This is a square banana"+"[/center]"

func hideDescription():
	# set description and name to blank.
	itemName.text = ""
	itemDescription.text = ""

func mergeItems(tag):
	# Set sent tags to three items.
	if merged == 1:
		itemOne = tag
		print("1")
	elif merged == 2:
		itemTwo = tag
		print("2")
	elif merged == 3:
		itemThree = tag
		print("3")
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
	
	var items = [itemOne, itemTwo, itemThree]
	
	var createdItem = ""
	
	if "banana" in items and "key" in items:
		createdItem = "apple"
	elif "apple" in items and "key" in items and "banana" in items:
		createdItem = "moon"
	#... Add more recipees here

		
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
