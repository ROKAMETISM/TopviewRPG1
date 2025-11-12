# TopviewRPG attempt 1

Designing a simple Topview RPG with survival elements.

## Features :
	
	- Inventory System
	
	- Interaction as Component

## Inventory system

See Scripts/Inventory

Inventory is defined with data as Dictionary, order as Array, and style resource.

Inventory holds a reference to its InventoryUI node, which is the visualization of the inventory.

InventoryStyle is defined with background texture, slot texture, scale factor and alpha value, etc.

InventoryUI is a tree of Control nodes, composited of NinePatchRect for background, GridContainer for slots, and InventorySlot class for all the individual slots.

Inventory UI holds a reference to its Inventory node.

InventorySlot scene is responsible for the visualization of each slots, and the player interaction between Inventory Visualization.

InventorySlot detects Mouse events as well as some Keyboard events to process which item is selected with what key input.

When it detects gui input, it sends a signal to its parent InventoryUI.

InventoryUI then processes the slot's signal, converting it into UIEventManager signal containing data of Item type and amount.

UIEventManager is an Autoload, which is responsible for handling UIInputs and delivering them to destinated game models.

In this case, UIEventManager.inventory_input is called, which is connected to the Player.

Finally, the Player knows about the inventory signal, thus processing the actual game logic (transferring item between player inventory and an external inventory, or dropping items from player inventory).


## Interaction system

An Interactable object is created by just attaching the "Interactable" component scene to the tree.

The InteractableComponent automatically handles interactable collision layer, highlighing and
emitting signal when interacted.

The actual interaction code is defined on the parent class, and the InteractableComponent only depends on it to work.

Highlighting an interactable object is implemented by outlining the sprite of the object.

## Outline Shader

I copied the outline shader code from the internet, and modified it so that it can be toggled real-time via code.

Studying shader is one of the future goals of this project.

## Todo 

-> Tool interface

->Interactive world interface -> HP


"Axe" -> chop tree

<>
