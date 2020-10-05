extends Node2D
class_name GhostGroup


func set_active(value):
	for child in get_children():
		child.set_active(value)


func activate():
	for child in get_children():
		child.activate()
	
func deactivate():
	for child in get_children():
		child.deactivate()

func toggle():
	for child in get_children():
		child.toggle()
