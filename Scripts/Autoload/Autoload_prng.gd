extends Node

var rng = RandomNumberGenerator.new()

func _ready():
	rng.seed = hash("pglowrpg")
	reset()

func randrange(min_v, max_v):
	var result = rng.randf_range(min_v, max_v)
	return result

func reset():
	rng.set_state(0)
