extends Node

@onready var audio_players : Dictionary = {
	"title": %Title,
	"combat": %Combat,
	
}

var music_bpm : float = 130.0
var seconds_per_beat : float = 0.0
var current_song_playing : AudioStreamPlayer

func play_song(song: String, starting_point: float = 0.0) -> void: ## Stops the current song playing and plays the selected song
	if not is_song_playing(song):
		stop_all_songs()
		audio_players[song].play(starting_point)
		current_song_playing = audio_players[song]

func stop_all_songs() -> void: ## Stops all songs
	for song in audio_players.values():
		if song is AudioStreamPlayer:
			
			if song.playing:
				song.stop()

func is_song_playing(song: String) -> bool:
	return audio_players[song].playing

func _ready() -> void:
	
	EventBus.MusicBeatTick.connect(beat_tick)
	EventBus.StartBeat.connect(start_beat)

func start_beat() -> void:
	seconds_per_beat = 60.0 / music_bpm

func beat_tick() -> void:
	pass

var current_beat : int
var beat : int
func _process(delta: float) -> void:
	if current_song_playing:
		beat = floor(current_song_playing.get_playback_position() / seconds_per_beat)
	
	if beat != current_beat:
		current_beat = beat
		EventBus.MusicBeatTick.emit()
