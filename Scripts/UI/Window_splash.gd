extends Control

const timeout = 1 # Seconds
var time = 0

func _ready():
	self.show()
	Paths.window_menu.hide()
	


func _process(delta):
	time += delta
	if time > timeout:
		self.hide()
		Paths.window_menu.show()
