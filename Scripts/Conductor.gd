extends Node
class_name Conductor
# The Conductor (optionally) plays a song, and sends signals based on the beats of the song.

# The beats per minute of the song
export(float, 1, 500) var song_bpm: float = 120

# Microseconds of silence present in the song
export(float, 0, 1000000) var song_offset: float = 0

# The time the song started playing at
var start_time: int

# The time of the last beat
var last_beat: int

# A song beat
signal beat


# Calculate the microseconds per beat
func usec_per_beat():
	return 60000000 / song_bpm


# Returns microseconds since the song start
func song_time():
	var current_time: int = OS.get_ticks_usec()
	return current_time - start_time
	
# Return corrected microseconds (after applying the offset) since the song start
func corrected_time():
	var song_time = song_time()
	return song_time - song_offset


# Start playing the song
func play():
	start_time = OS.get_ticks_usec()
	$Music.play()


# Signal that a beat has happened
func beat():
	pass


func _ready():
	play()


func _process(delta):
	var time = corrected_time()
	if time - last_beat >= usec_per_beat():
		emit_signal("beat")
		last_beat = time


func _on_Conductor_beat():
	print("Beat! %f" % song_time())
