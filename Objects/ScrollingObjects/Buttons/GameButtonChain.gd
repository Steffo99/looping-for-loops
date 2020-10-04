extends Node2D


func _ready():
	var children: Array = get_children()
	for i in len(children):
		if i == 0:
			children[i].set_active(true)
		else:
			children[i].set_active(false)
		if i < len(children) - 1:
			children[i].connect("clicked", children[i+1], "activate")
