extends Node

# Default.
var map_size = 256

func start():
	# Start time measurement.
	var time1 = Time.get_ticks_msec()
	Paths.window_worldgen_text.text = ""
	Paths.window_worldgen_text.text += "Generating diamond-square noise...\n"
	
	# Topology generation.
	var array = ArrayOps.diamond_square_get(map_size, 1.0, 0.0, 0.0)
	
	Paths.window_worldgen_text.text += "Outputting the image texture...\n"
	var image = Image.create_from_data(map_size, map_size, false, Image.FORMAT_L8, array)
	#image.resize(512,512,Image.INTERPOLATE_LANCZOS)
	var texture = ImageTexture.create_from_image(image)
	Paths.window_worldgen_image.texture = texture
	
	# Reset the PRNG in the end and unlock the generator.
	Prng.reset()
	
	# Get elapsed time.
	var time2 = Time.get_ticks_msec()
	Paths.window_worldgen_text.text += "Done in " + str((time2-time1)/1000.0) + " seconds."
	
