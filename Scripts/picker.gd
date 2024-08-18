extends VBoxContainer


func _on_button_toggled(toggled_on: bool) -> void:
	$ColorPicker.visible = toggled_on


func _on_color_picker_color_changed(color: Color) -> void:
	if BuildPlate.instance.selColor != color:
		BuildPlate.instance.selColor = color
		for i in $"../../blocks".get_children():
			i.material_override = StandardMaterial3D.new()
			i.material_override.albedo_color = color
			if color.a < 1:
				i.material_override.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
