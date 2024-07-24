extends Node


##func _ready():
##func on_button_pressed() -> void:
	##match button.name:
		###"cinema":
			##var _cinema: bool = get_tree().change_scene("res://scenes/cinema.tscn")
		##"musica":
			##var _musica: bool = get_tree().change_scene("res://scenes/musica.tscn")


func _on_cinemamenu_pressed():
	get_tree().change_scene_to_file("res://scenes/cinema.tscn")


func _on_musicamenu_pressed():
	get_tree().change_scene_to_file("res://scenes/musica.tscn")
