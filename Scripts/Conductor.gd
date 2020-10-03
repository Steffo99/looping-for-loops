extends Node
class_name Conductor
# The Conductor (optionally) plays a song, and sends signals based on the beats of the song.

# The beats per minute of the song
export(float, 1, 500) var song_bpm: float = 120

# Microseconds of silence present in the song
export(float, 0, 1000000) var song_offset: float = 0

# The time the song started playing at
var start_time: int

# Song beats signals
signal quarter_beat
signal half_beat
signal beat
signal four_beats
signal two_beats

# The time of the last quarter_beat
var last_qb: int

# The count of quarter_beats so far
var count_qb: int = 0


# Calculate the microseconds per beat
func usec_per_quarter_beat():
	return 60000000 / (song_bpm * 4)


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
	count_qb = 0
	$Music.play()


func _ready():
	play()


func _process(delta):
	var time = corrected_time()
	if time - last_qb >= usec_per_quarter_beat():
		emit_signal("quarter_beat")
		if count_qb % 2 == 0:
			emit_signal("half_beat")
		if count_qb % 4 == 0:
			emit_signal("beat")
		if count_qb % 8 == 0:
			emit_signal("two_beats")
		if count_qb % 16 == 0:
			emit_signal("four_beats")
		last_qb = time
		count_qb += 1
