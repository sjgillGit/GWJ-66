extends Panel

# Using the inspector
## Put the name of the item meant to go in this inventory space.
@export var inventoryTag = ""

## Check this if its put in the quick inventory
@export var quickInventorySlot = false

@export var itemImageTexutre = Texture
@export var itemSilhouetteTexture = Texture

# These variables are the only thing needed to be saved for inventory.
var hasItemBool = false
var itemUsedBool = false

#Player Dragging And Dropping
var mouseOverItem = false
var dragging = false

#Sprite for the item, will be changed between - ? - Item Image - Silhouette Of Item -
@onready var itemSprite = $ItemSprite/Item
@onready var spritePos = $ItemSprite

#Inventory
@onready var Inventory = $"../../../.."
@onready var itemName = $name


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# Here Load Save File if any and change image #
	
	#Change text if not quick, based on whether known or not
	if !quickInventorySlot :
		if hasItemBool || itemUsedBool:
			itemName.text = "[center]"+inventoryTag+"[/center]"
		else:
			itemName.text = "[center]"+"???"+"[/center]"

func _physics_process(delta):
	#Implement dragging, if true follow cursor. Otherwise move back.
	if dragging == true:
		itemSprite.global_position = get_global_mouse_position()
	else:
		itemSprite.global_position = spritePos.global_position
		
	#If mouse over and left button held down, as well as having the item. Start dragging, otherwise stop.
	if hasItemBool == true:
		if Input.is_action_just_pressed("LeftMouse"):
			if mouseOverItem == true:
				dragging = true
		elif Input.is_action_just_released("LeftMouse"):
			dragging = false

func itemGrabbed(itemTag):
	#check if item picked up should be put here.
	if itemTag == inventoryTag:
		hasItemBool = true
		#Change image to - Item Image And change text if normal
		itemSprite.texture = itemImageTexutre
		
		if !quickInventorySlot:
			itemName.text = "[center]"+inventoryTag+"[/center]"
		
func itemUsed(itemTag):
	#check if item picked up should be put here.
	if itemTag == inventoryTag && hasItemBool == true:
		hasItemBool = false
		itemUsedBool = true
		#Change image to - Item Silhouette
		itemSprite.modulate.a = 0.5
		itemSprite.texture = itemSilhouetteTexture

func _on_mouse_entered():
	#Only allow dragging if in quick inventory
	if quickInventorySlot:
		mouseOverItem = true
	# Do this only if its a normal inventory slot
	if !quickInventorySlot:
		Inventory.showDescription(inventoryTag,hasItemBool,itemUsedBool)
	
func _on_mouse_exited():
	#Only allow dragging if in quick inventory
	if quickInventorySlot:
		mouseOverItem = false
	# Do this only if its a normal inventory slot
	if !quickInventorySlot:
		Inventory.hideDescription()

