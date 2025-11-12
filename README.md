# TopviewRPG attempt 1

Designing a simple Topview RPG with survival elements.

## Features :
	
	- Inventory System
	
	- Interaction as Component

## Inventory system

Inventory is defined with data as Dictionary, order as Array, and style resource.

InventoryStyle is defined with background texture, slot texture, scale factor and alpha value, etc.

InventoryVisualizer is an Autoload(Singleton pattern)
which is responsible for creating and updating an Inventory's visualization.

When requested to visualize an Inventory, it will automatically create a Control node that has all the
UI elements like background and slots as its child tree then pass it to the caller.

InventoryVisualizer also updates the existing visualization of an inventory, if it has one.

## Interaction system

An Interactable object is created by just attaching the "Interactable" component scene to the tree.

The InteractableComponent automatically handles interactable collision layer, highlighing and
emitting signal when interacted.

The actual interaction code is defined on the parent class, and the InteractableComponent only depends on it to work.

## Todo 

-> Tool interface

->Interactive world interface -> HP


"Axe" -> chop tree

<>
