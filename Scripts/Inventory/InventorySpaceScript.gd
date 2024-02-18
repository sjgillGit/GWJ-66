extends Panel

# Using the inspector
## Put the name of the item meant to go in this inventory space.
@export var inventoryTag = ""

@export var itemImageTexutre = Texture

## Check this if its put in the quick inventory
@export var quickInventorySlot = false

#Chemical Solution
var AcidBottleSprite = preload("res://Gui/Images/ItemImages/Chemical Solution/AcidBottle.png")
var ChemicalSolutionSprite = preload("res://Gui/Images/ItemImages/Chemical Solution/Solution.png")
var crushedPills = preload("res://Gui/Images/ItemImages/Chemical Solution/CrushedPills.png")

#Merging Items
@export var mergeItemSlot = false
@export var scene_interaction:SceneInteraction
var mouseOverMergeSlot = false
var merged = 0

var normalSlot = true
var mouseOverNormalSlot = false

# These variables are the only thing needed to be saved for inventory.
var hasItemBool = false
var itemUsedBool = false

#Player Dragging And Dropping
var mouseOverQuickSlot = false
var dragging = false

#Sprite for the item, will be changed between - ? - Item Image - Silhouette Of Item -
@onready var itemSprite = $ItemSprite/Item
@onready var spritePos = $ItemSprite

#Inventory
@onready var Inventory = $"../../../.."
@onready var itemName = $name

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if !quickInventorySlot && !mergeItemSlot:
		normalSlot = true
	else:
		normalSlot = false
	
	# Here Load Save File if any and change image #
	
	
	#Change text if normal, based on whether known or not
	if normalSlot :
		if hasItemBool || itemUsedBool:
			itemName.text = "[center]"+inventoryTag+"[/center]"
		else:
			itemName.text = "[center]"+"???"+"[/center]"

func _physics_process(_delta):
	#Implement dragging, if true follow cursor. Otherwise move back.
	if dragging:
		itemSprite.global_position = get_global_mouse_position()
		
		if normalSlot:
			#If dragging a normal slot item, set the variables to parent script to be access by merge slot.
			Inventory.mergingItemSprite = itemImageTexutre
			Inventory.mergingItemTag = inventoryTag
			Inventory.dragging = true
			scene_interaction.is_dragging_item = true
	else:
		itemSprite.global_position = spritePos.global_position
		
	#If mouse over and left button held down, as well as having the item. Start dragging, otherwise stop.
	checkDragging()
	
	# Basically, if mouse is hovering over merge while dragging an item, and they let go, it moves it.
	if mouseOverMergeSlot == true && Inventory.dragging:
		if Input.is_action_just_released("ui_mouse_left"):
			#Set variables of the merge slot to match dragged item
			inventoryTag = Inventory.mergingItemTag
			itemImageTexutre = Inventory.mergingItemSprite
			itemSprite.texture = itemImageTexutre
			Inventory.hideError()

func checkDragging():
	if hasItemBool:
		if Input.is_action_just_pressed("ui_mouse_left"):
			if mouseOverQuickSlot || mouseOverNormalSlot:
				dragging = true
				scene_interaction.is_dragging_item = true
				scene_interaction.dragged_item = inventoryTag
				if !quickInventorySlot:
					Inventory.dragging = true
			elif !quickInventorySlot:
				Inventory.dragging = false
		elif Input.is_action_just_released("ui_mouse_left"):
			dragging = false
			scene_interaction.is_dragging_item = false

func itemUsed(itemTag):
	
	if hasItemBool == true:
		if itemTag == "Bottle" && inventoryTag == "Bottle":
			inventoryTag = "Acid Bottle"
			if !quickInventorySlot:
				itemName.text = inventoryTag
			itemImageTexutre = AcidBottleSprite
			itemSprite.texture = AcidBottleSprite
			if quickInventorySlot:
				itemImageTexutre = null
				itemSprite.texture = null
			
		elif itemTag == "Acid Bottle" && inventoryTag == "Acid Bottle":
			inventoryTag = "Chemical Solution"
			itemName.text = inventoryTag
			itemImageTexutre = ChemicalSolutionSprite
			itemSprite.texture = ChemicalSolutionSprite
			get_tree().call_group("InventorySpot", "itemGrabbed", "Chemical Solution")
			
		elif itemTag == "Pill Bottle" && inventoryTag == "Pill Bottle":
			inventoryTag = "Crushed Pills"
			itemName.text = inventoryTag
			itemImageTexutre = crushedPills
			itemSprite.texture = crushedPills
			
		elif itemTag == "Knife":
			GlobalScript.playerUsingKnife = true
		
		#check if item picked up should be put here.
		elif itemTag == inventoryTag:
			hasItemBool = false
			itemUsedBool = true
			#Change image to - Item Silhouette
			itemSprite.modulate.a = 0.2
			itemSprite.texture = itemImageTexutre
	
func itemGrabbed(itemTag):
	#check if item picked up should be put here.
	if itemTag == inventoryTag:
		hasItemBool = true
		#Change image to - Item Image And change text if normal
		itemSprite.texture = itemImageTexutre
		if normalSlot:
			itemName.text = "[center]"+inventoryTag+"[/center]"

func _on_mouse_entered():
	#Only allow dragging if in quick inventory
	if quickInventorySlot:
		mouseOverQuickSlot = true
		GlobalScript.usingQuickInventory = true
		
	# Do this only if its a normal inventory slot
	elif mergeItemSlot:
		mouseOverMergeSlot = true
		GlobalScript.usingQuickInventory = false
	
	elif normalSlot:
		mouseOverNormalSlot = true
		Inventory.showDescription(inventoryTag,hasItemBool,itemUsedBool)
	
func _on_mouse_exited():
	#Only allow dragging if in quick inventory
	if quickInventorySlot:
		mouseOverQuickSlot = false
		
	# Do this only if its a normal inventory slot
	elif mergeItemSlot:
		mouseOverMergeSlot = false
		
	elif normalSlot:
		mouseOverNormalSlot = false
		Inventory.hideDescription()

func sendMerges():
	# Calls merged slot groups, they then send tag to parent script.
	Inventory.mergeItems(inventoryTag)

func clear():
	inventoryTag = ""
	itemImageTexutre = null
	itemSprite.texture = null

