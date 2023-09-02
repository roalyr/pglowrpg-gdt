extends Node

func index_get(map_size : int, x : int, y: int):
	var result : int = y * map_size + x
	return result
	
func index_get_mirrored_h(map_size : int, x : int, y: int):
	# let result = ((self.map_size - y - 1) * self.map_size).checked_add(x);
	var result : int = (map_size - y - 1) * map_size + x
	return result
	
func index_get_mirrored_v(map_size : int, x : int, y: int):
	# let result = (y * self.map_size).checked_add(self.map_size - x - 1);
	var result : int = y * map_size + (map_size - x - 1)
	return result

func index_get_mirrored_hv(map_size : int, x : int, y: int):
	# let saturated = ((self.map_size - y - 1) * self.map_size).saturating_add(self.map_size - x - 1);
	var result : int = (map_size - y - 1) * map_size + (map_size - x - 1)
	return result
