@tool
extends Node3D

@export var planet_data: Resource:
	set(val):
		planet_data = val
		on_data_changed()

func _ready() -> void:
	on_data_changed()

func on_data_changed() -> void:
	for child in get_children():
		var face = child as PlanetMeshFace
		if face:
			face.regenerate_mesh(planet_data)
