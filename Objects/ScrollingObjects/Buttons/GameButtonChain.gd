extends Node2D

var chain_icons: Array = [
	preload("res://Sprites/1.png"),
	preload("res://Sprites/2.png"),
	preload("res://Sprites/3.png")
]


func _ready():
	var children: Array = get_children()
	for i in len(children):
		if i == 0:
			children[i].set_active(true)
		else:
			children[i].set_active(false)
		if i < len(children) - 1:
			children[i].set_icon(chain_icons[i])
			children[i].connect("clicked", children[i+1], "activate")
