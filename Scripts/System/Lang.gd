class_name Lang

static var current_lang: Enums.Lang = Enums.Lang.En


# -------
# Get string from lang file
# Example: var result = Lang.get_line("example", "test")
# -------
static func get_line(file_path: String, line: String) -> String:
	var file = FileAccess.open("res://Assets/Lang/{lang}/{file}.json".format({
		"lang": get_lang_code(),
		"file": file_path
	}), FileAccess.READ)
	if !file: return ""
	
	var content = file.get_as_text()
	var json = JSON.parse_string(content)
	if json && json.has(line):
		return json[line]
	return ""



static func get_lang_code() -> String:
	return Enums.Lang.keys()[current_lang]
