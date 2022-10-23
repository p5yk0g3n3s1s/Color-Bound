extends Node2D

func _ready():
	if not GLOBALS.replay:
		pause_game(true)
	random_start()


func random_start():
	reset_globals()
	var particle_material = $Ball/Particles2D.process_material
	particle_material.color = Color.black

	# Random Direction
	if randi() % 2 == 1:
		GLOBALS.ud_dir = -1
		particle_material.gravity.y = -1000
	else:
		particle_material.gravity.y = 1000
	particle_material.gravity.x = -1000

	# Random Position
	var start_pos = 'StartPositions/StartPos' + str(randi() % 5 + 1)
	$Ball.position = get_node(start_pos).position


func _on_OutBounds_body_entered(body):
	if body and body.name == 'Ball':
		$PauseMenu/VBoxContainer/PlayButton.text = 'Replay?'
		pause_game(true)


func reset_globals():
	var starting_color = GLOBALS.starting_color
	GLOBALS.ud_dir = 1
	GLOBALS.lr_dir = 1
	GLOBALS.level = 1
	GLOBALS.time = 0
	GLOBALS.ball_speed = 500
	GLOBALS.top_color = starting_color
	GLOBALS.side_color = starting_color
	GLOBALS.bottom_color = starting_color


func _input(event):
	if event.is_action_pressed("ui_cancel"):
		pause_game(true)


func pause_game(value):
	$PauseMenu.visible = value
	get_tree().paused = value


func _on_Timer_timeout():
	GLOBALS.time += 1
	$TimerLabel.text = 'Time: ' + str(GLOBALS.time)


## Pause Menu ##
func _on_PlayButton_pressed():
	if $PauseMenu/VBoxContainer/PlayButton.text == 'Replay?':
		get_tree().change_scene("res://Scenes/Level.tscn")
		GLOBALS.replay = true
	pause_game(false)


func _on_MusicButton_pressed():
	if GLOBALS.music:
		$PauseMenu/VBoxContainer/MusicButton.text = "Music: Off"
		GLOBALS.music = false
		$MusicAudio.stop()
	else:
		$PauseMenu/VBoxContainer/MusicButton.text = "Music: On"
		GLOBALS.music = true
		$MusicAudio.play()


func _on_SoundFxButton_pressed():
	if GLOBALS.sound_fx:
		$PauseMenu/VBoxContainer/SoundFxButton.text = "Sound Fx: Off"
		GLOBALS.sound_fx = false
	else:
		$PauseMenu/VBoxContainer/SoundFxButton.text = "Sound Fx: On"
		GLOBALS.sound_fx = true
