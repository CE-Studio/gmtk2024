extends MeshInstance3D


@export var id:int


func _on_static_body_3d_input_event(camera: Node, event: InputEvent, position: Vector3, normal: Vector3, shape_idx: int) -> void:
	if event.is_action_pressed("game_place"):
		BuildPlate.instance.setBrick(id)
