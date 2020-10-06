extends Node


var loops_collected: int = 0
var rng: RandomNumberGenerator = RandomNumberGenerator.new()


func _init():
	rng.randomize()
