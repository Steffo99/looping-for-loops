extends Node
class_name Conductor
# The Conductor (optionally) plays a song, and sends signals based on the beats of the song.

# The beats per minute of the song
export(float, 1, 500) var song_bpm: float = 120

# Microseconds of silence present in the song
export(float, 0, 1000000) var song_offset: float = 0

# The time the song started playing at
var start_time: int

# Beat signal
signal subbeat(subbeat_num)

# The time of the last quarter_beat
var last_subbeat: int

# The count of quarter_beats so far
var subbeat_count: int = 0


# Calculate the microseconds per 1/12 beat
func subbeat_usec():
	return 60000000 / (song_bpm * 12)


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
	subbeat_count = 0
	$Music.play()


func _ready():
	play()


func _process(delta):
	var time = corrected_time()
	if time - last_subbeat >= subbeat_usec():
		emit_signal("subbeat", subbeat_count)
		last_subbeat = time
		subbeat_count += 1
