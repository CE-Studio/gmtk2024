extends MeshInstance3D


func _on_static_body_3d_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("game_place"):
		for i in $"../../blocks".get_children():
			i.material_override = material_override
		BuildPlate.instance.selColor = Color(material_override.albedo_color)
		$"../../PanelContainer/VBoxContainer/ColorPicker".color = Color(material_override.albedo_color)
