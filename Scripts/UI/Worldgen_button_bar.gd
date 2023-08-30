extends Control


func _on_button_back_pressed():
	Paths.window_worldgen.hide()
	Paths.window_menu.show()


func _on_button_start_pressed():
	Paths.worldgen.start()
