extends Spatial


export var double_bar_x_offset : float = 1.65
export var camera_base_size : float = 5.0
export var camera_max_size : float = 100.0
export var stat_base_scale : float = 1.0
export var stat_max_scale : float = 5.0
export var max_graph_count : int = 100

var double_bar_scene = preload("res://Scenes/StatsBar3D/DoubleStatsBar3D.tscn")
var double_bars : Array = []

func _new_double_bar() -> DoubleStatsBar3D:
	var double_bar_instance = double_bar_scene.instance()
	add_child(double_bar_instance)
	double_bars.append(double_bar_instance)
	return double_bar_instance

func reset_graph_positions():
	var iter : int = 0
	var size : int = double_bars.size()
	$StatsFlatBase3D.scale.x = float(size)
	var max_ratio : float = float(size) / float(max_graph_count)
	var total_length : float = double_bar_x_offset * size
	for double_bar in double_bars:
		var ratio = float(iter) / float(size)
		double_bar.translation.x = (ratio * total_length) - (total_length / 2) + double_bar_x_offset / 2
		iter += 1
		double_bar.set_stat_scale((max_ratio * (stat_max_scale - stat_base_scale)) + stat_base_scale)
	$Spatial/Camera.size = int((camera_max_size - camera_base_size) * max_ratio + camera_base_size)

func add_graph():
	$StatsFlatBase3D.visible = true
	if double_bars.size() >= max_graph_count:
		return
	var double_bar : DoubleStatsBar3D = _new_double_bar()
	reset_graph_positions()
	return double_bar

func assign_character_index(character, index):
	var double_bar : DoubleStatsBar3D = double_bars[index]
	double_bar.character = character
