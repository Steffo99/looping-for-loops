extends CollisionShape2D
class_name RecreatingRectangleShape


func _ready():
	var extents = shape.extents
	var custom_solver_bias = shape.custom_solver_bias
	shape = RectangleShape2D.new()
	shape.extents = extents
	shape.custom_solver_bias = custom_solver_bias
