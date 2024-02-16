extends Resource
class_name Dialogue


signal speech_triggered(speaker_name:String, message:String)


var speech_buffer:Array
var is_waiting_response:bool = false


func make_speak(speaker_name:String, message:String):
	if !speech_buffer.is_empty():
		if [speaker_name, message] == speech_buffer.back(): # avoid repetative messages
			return
	speech_buffer.append([speaker_name, message])
	if !is_waiting_response:
		trigger_next_speech()


func trigger_next_speech():
	if speech_buffer.is_empty():
		return
	var next_speech = speech_buffer.pop_at(0)
	speech_triggered.emit(next_speech[0], next_speech[1])
	is_waiting_response = true

# receive response about speech being fully delivered
func receive_response():
	is_waiting_response = false
	trigger_next_speech()
