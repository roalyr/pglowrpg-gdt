extends Control

func _ready():
	self.hide()

func popup_panic(message):
	var panic_message = self.get_node("Panic_message")
	get_tree().get_root().get_node("Main").hide()
	self.show()
	panic_message.text = message
	# Also write down the message into console.
	var div = "\n\n============================= P A N I C =============================\n\n"
	print(div + message + div)
	# Pause the game and prompt exit with the button.
	get_tree().paused = true


func _on_button_pressed():
	get_tree().quit()
