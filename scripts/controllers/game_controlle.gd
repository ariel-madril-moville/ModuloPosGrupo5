extends Node
@export var quiz:QuizTheme
@export var color_right: Color
@export var color_wrong: Color

@onready var personagem = [$"Hangman-game-og-share",$BracoD, $BracoE,$PernaE,$PernaD, $Tronco2, $"Cabeça"]
var buttons: Array[Button]
var index: int
var correct: int

@onready var question_texts = $content/QuestionInfo/QuestionText
@onready var question_image = $content/QuestionInfo/ImageHolder/QuestionImage
@onready var question_video = $content/QuestionInfo/ImageHolder/QuestionVideo
@onready var question_audio = $content/QuestionInfo/ImageHolder/questionAudio




func _ready():
	for button in $content/QuestionHolder.get_children():
		buttons.append(button)
	load_quiz()



func load_quiz() -> void:
	if index >= quiz.theme.size():
		_game_over()
		return
	question_texts.text = quiz.theme[index].question_info
	
	var options = quiz.theme[index].options
	for i in buttons.size():
		buttons[i].text = options[i]
		buttons[i].pressed.connect(_buttons_answer.bind(buttons[i]))

	match quiz.theme[index].type:
		Enum.QuestionType.TEXT:
			$content/QuestionInfo/ImageHolder.hide()
			
		Enum.QuestionType.IMAGE:
			$content/QuestionInfo/ImageHolder.show()
			question_image.texture = quiz.theme[index].question_image
			
		Enum.QuestionType.VIDEO:
			$content/QuestionInfo/ImageHolder.show()
			question_video.stream = quiz.theme[index].question_video
			question_video.play()
			
		Enum.QuestionType.AUDIO:
			$content/QuestionInfo/ImageHolder.hide()
			question_audio.stream = quiz.theme[index].question_audio
			question_audio.play()


func _buttons_answer(button) -> void:
	if quiz.theme[index].corret == button.text:
		button.modulate = color_right
		correct += 1
		_esconderpersonagem()
	else:
		button.modulate = color_wrong
	
	_proxima()
		
func _proxima() -> void:
	for bt in buttons:
		bt.pressed.disconnect(_buttons_answer)
		
	await get_tree().create_timer(1).timeout
		
	for bt in buttons:
		bt.modulate = Color.WHITE
		
	question_audio.stop()
	question_video.stop()
	question_audio.stream = null
	question_video.stream = null
	
	index += 1
	load_quiz()
	
	
func _game_over() -> void:
	$content/ColorRect.show()
	print ("acabou")

func _esconderpersonagem():
	if correct <= 6:
		personagem[correct].hide()
	
	
func _on_btreplay_pressed():
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
