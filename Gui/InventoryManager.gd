extends Control

@onready var quickInventory = $QuickInventory
@onready var Inventory = $Normal
@onready var openQuickButton = $QIbutton

var inventoryOpen = false
var quickInventoryOpen = false

#Text Descriptions
@onready var itemDescription = $Normal/Panel/ItemDescription/ItemDescription
@onready var itemName = $Normal/Panel/ItemDescription/ItemName

# Called when the node enters the scene tree for the first time.
func _ready():
	quickInventory.hide()
	Inventory.hide()
	itemName.text = ""
	itemDescription.text = ""

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

func hideDescription():
	# set description and name to blank.
	itemName.text = ""
	itemDescription.text = ""

