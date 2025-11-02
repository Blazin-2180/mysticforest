extends Node

var music_audio_player_count : int = 2
var current_music_player : int = 0
var music_players : Array[ AudioStreamPlayer ] = []
var music_bus : String = "Music"
var music_fade_duration : float = 0.5

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	for m in music_audio_player_count :
		var player = AudioStreamPlayer.new()
		add_child( player )
		player.bus = music_bus
		music_players.append( player )
		player.volume_db = -40
	pass

func play_music( _audio : AudioStream ) -> void : 
	if _audio == music_players[ current_music_player ].stream :
		return
		#If you want to keep the music playing even when entering an area you have not assigned audio
	#elif _audio == null :
		#return
	
	current_music_player += 1
	if current_music_player > 1 :
		current_music_player = 0
	
	var current_player : AudioStreamPlayer = music_players[ current_music_player ]
	current_player.stream = _audio
	fade_in( current_player )
	
	var previous_player = music_players[1]
	if current_music_player == 1 :
		previous_player = music_players[0]	
	fade_out( previous_player )
	

func fade_in( player : AudioStreamPlayer ) -> void :
	player.play( 0 )
	
	var tween : Tween = create_tween()
	tween.tween_property( player, 'volume_db', 0, music_fade_duration )
	pass

func fade_out( player : AudioStreamPlayer ) -> void :
	var tween : Tween = create_tween()
	tween.tween_property( player, 'volume_db', -40, music_fade_duration )
	await tween.finished
	player.stop()
	pass
