extends Node3D


func _ready() -> void:
	var sw = preload("res://Scenes/swatch.tscn")
	var pos:int = 0
	for r in [0, 0.25, 0.5, 0.75, 1]:
		for g in [0, 0.25, 0.5, 0.75, 1]:
			for a in [0.5, 1]:
				for b in [0, 0.25, 0.5, 0.75, 1]:
					var col := Color(r, g, b, a)
					var i = sw.instantiate()
					i.material_override = StandardMaterial3D.new()
					i.material_override.albedo_color = col
					if a != 1:
						i.material_override.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
					add_child(i)
					i.position.x = (pos % 10) / 10.0
					i.position.z = floor(pos / 10) / 10.0
					print(i.position)
					pos += 1
