extends Node

var size : int = 1
#var length_big : int = 1
var array : Array = []
var array_final : Array = []
var land_concentrator = 1.0
var land_scope = 1.0
var land_continuity = 1.0
var iter = 0
var step_len = 1
var step_increment = 1


# A margin that is meant to crop the border artifacts in DS algorithm
const crop_factor = 0.1


func diamond_square_get(
	inp_size : int, 
	inp_land_concentrator, 
	inp_land_scope, 
	inp_land_continuity) -> Array:
	
	size = inp_size
	# size+1 in both directions
	var length_big = (size * size + 2 * size + 1)
	array.resize(length_big)
	array.fill(1.0)
	land_concentrator = inp_land_concentrator
	land_scope = inp_land_scope
	land_continuity = inp_land_continuity
	iter = 0
	step_len = size
	step_increment = 1

	while step_len > 1:
		# square step
		var x = 0
		for i in range(step_increment):
			var  y = 0
			for j in range(step_increment):
				var region_x = step_len + x
				var region_y = step_len + y
				iter += 1
				var half_size = (region_x - x) / 2
				var center_x = x + half_size
				var center_y = y + half_size
				var sum = \
					+ array[Units.index_get(size, x, y)] \
					+ array[Units.index_get(size, x, region_y)] \
					+ array[Units.index_get(size, region_x, y)] \
					+ array[Units.index_get(size, region_x, region_y)]
				var shift = Prng.randrange(
					-half_size + land_continuity * half_size * (1.0 - land_concentrator),
					half_size + land_continuity * half_size * (1.0 - land_concentrator)
				)
				var avg = sum / 4.0 \
					+ (1.0 - land_concentrator) * land_scope * sum * shift \
					+ land_concentrator * shift 
				array[Units.index_get(size, center_x, center_y)] = avg
				y += step_len
			
			x += step_len
		
		# diamond step
		x = 0
		for i in range(step_increment):
			var  y = 0
			for j in range(step_increment):
				var region_x = step_len + x
				var region_y = step_len + y
				diamond_substep(x, (region_y + y) / 2)
				diamond_substep(region_x, (region_y + y) / 2)
				diamond_substep((region_x + x) / 2, y)
				diamond_substep((region_x + x) / 2, region_y)
				y += step_len
			
			x += step_len
		
		step_len /= 2
		step_increment *= 2
	
	#return array
	return normalize_crop()


func diamond_substep(center_x: int, center_y: int):
	iter += 1
	var half_size = step_len / 2
	var sum2 = \
		+ array[Units.index_get(size, (center_x - half_size) % size, center_y)] \
		+ array[Units.index_get(size, (center_x + half_size) % size, center_y)] \
		+ array[Units.index_get(size, center_x, (center_y - half_size) % size)] \
		+ array[Units.index_get(size, center_x, (center_y + half_size) % size)]
	var shift = Prng.randrange(
		-half_size + land_continuity * half_size * (1.0 - land_concentrator),
		half_size + land_continuity * half_size * (1.0 - land_concentrator)
	)
	var avg2 = (land_concentrator * sum2 / 4.0 * half_size \
		+ (1.0 - land_concentrator) * land_scope * sum2 * shift \
		+ land_concentrator * land_scope * shift \
		+ (1.0 - land_concentrator) * sum2 / 4.0) \
		/ (land_concentrator * half_size + (1.0 - land_concentrator))
		
	array[Units.index_get(size, center_x, center_y)] = avg2


func normalize_crop() -> Array:
	var length = (size * size)
	array_final.resize(length)
	array_final.fill(0.0)

	# Find maximum and minimum values for normalization.
	var max_v = 0.0
	var min_v = 0.0
	for i in range(len(array)):
		var cell_v = array[i]
		if cell_v > max_v:
			max_v = cell_v
		if cell_v < min_v:
			min_v = cell_v
	
	# Normalize.
	var k = 255 / (max_v - min_v)
	for i in range(length):
		array_final[i] = clampi(int((array[i] + abs(min_v)) * k), 0, 255)
	
	# Manipuate the array as an image for better speed.
	var image = Image.create_from_data(size, size, false, Image.FORMAT_L8, array_final)
	image.resize(size + int(size*crop_factor), size + int(size*crop_factor), Image.INTERPOLATE_LANCZOS)
	# Crop first two sides.
	image.crop(size + int(size*crop_factor) / 2, size + int(size*crop_factor) / 2)
	# Flip and crop other two sides.
	image.flip_x()
	image.flip_y()
	image.crop(size, size)
	# Flip the image back.
	image.flip_x()
	image.flip_y()
	# Return the data to array.
	array_final = image._get_data()["data"]
	
	return array_final
