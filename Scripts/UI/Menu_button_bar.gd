extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_button_quit_pressed():
	get_tree().quit()


func _on_button_worldgen_pressed():
	Paths.window_worldgen.show()
	Paths.window_menu.hide()
