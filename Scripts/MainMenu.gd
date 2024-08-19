extends Control


const fade_amount:float = 4.0
var credits_open:bool = false


@onready var credits:TextureRect = $"CreditsParent"


func _ready():
	pass # Replace with function body.


func _process(delta):
	if credits_open:
		credits.modulate.a = lerp(credits.modulate.a, 1.0, delta * fade_amount)
	else:
		credits.modulate.a = lerp(credits.modulate.a, 0.0, delta * fade_amount)


func on_play_button():
	if !credits_open:
		get_tree().change_scene_to_file("res://Scenes/game.tscn")


func on_credits_button():
	credits_open = true
	credits.visible = true
	credits.modulate.a = 0.0


func on_credits_return():
	credits.visible = false
	credits_open = false
