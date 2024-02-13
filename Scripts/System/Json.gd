extends Node

class_name JsonHelper


# ---
# Read file from user json folder
# Example: var result = JsonHelper.read_file("example")
# ---
static func read_file(file_name: String) -> Dictionary:
	var file = FileAccess.open_compressed("user://" + file_name + ".json", FileAccess.READ)
	if !file: return {}
	
	var content = file.get_as_text()
	return JSON.parse_string(content)


# ---
# Write file to user json folder
# Example: var result = JsonHelper.write_file("example", {"test": "123"})
# ---
static func write_file(file_name: String, data: Dictionary) -> void:
	var file = FileAccess.open_compressed("user://" + file_name + ".json", FileAccess.WRITE)
	var json_data = JSON.stringify(data)
	file.store_string(json_data)

