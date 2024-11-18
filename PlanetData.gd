@tool
class_name PlanetData
extends Resource


@export var radius = 1: 
	set(val): 
		radius = val
		emit_changed()
	get:
		return radius

@export var resolution := 10.0 : 
	set(val): 
		resolution = val
		emit_changed()
		
@export var amplitude := 1.0 : 
	set(val): 
		amplitude = val
		emit_changed()

@export var min_height := 0.0 : 
	set(val): 
		min_height = val
		emit_changed()
		


@export var noise_map: FastNoiseLite :
	set(val):
		if noise_map:  # Disconnect the old resource signal if it exists
			noise_map.changed.disconnect(_on_resource_changed)
		noise_map = val
		if noise_map:  # Connect the new resource signal
			noise_map.changed.connect(_on_resource_changed)
	get:
		return noise_map

func _on_resource_changed():
	emit_changed()

func point_on_planet(point_on_sphere : Vector3) -> Vector3:
	var elevation = noise_map.get_noise_3dv(point_on_sphere * 100.0)
	elevation = elevation + 1 / 2.0 * amplitude
	elevation = max(0.0, elevation - min_height) 	
	return point_on_sphere * radius * (elevation + 1.0) 
