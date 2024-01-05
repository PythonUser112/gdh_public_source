extends HTTPRequest

var addon = ""
var addon_stack = []

func nload(file):
	if File.new().file_exists("user://"+file):
		return load("user://"+file)
	return load("res://"+file)

func bload(file):
	if File.new().file_exists("user://"+file):
		return load("user://"+file).instance()
	return load("res://"+file).instance()

func load_addon(_addon):
	return load("user://"+_addon+"_Main.tscn").instance()

func install_addon(_addon):
	if addon:
		addon_stack.append(_addon)
		return
	addon = _addon
	var f = File.new()
	f.open("user://addons.txt", File.WRITE_READ)
	var cont = f.get_as_text()+addon+"\n"
	f.store_string(cont)
	download_file = "user://"+addon+"_Main.tscn"
# warning-ignore:return_value_discarded
	request("http://github.com/PythonUser112/gdh_addons/blob/main/"+addon+"_Main.tscn")

func _on_HTTPRequest_request_completed(_result, _response_code, _headers, _body):
	print(_body.get_string_from_utf8())
	print("Downloaded addon "+addon+".")
	var tscn = load_addon(addon)
	tscn.install()
	addon = ""
	if addon_stack:
		install_addon(addon_stack.pop_front())
