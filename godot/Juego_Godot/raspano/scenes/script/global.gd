extends Node

var playerBody: CharacterBody2D
var spawn_point = Vector2(-550,225)
var total_scenes = 0
var total_points = 0
var total_level_point = 0
var player_name = ""

func update_spawn(new_point):
	spawn_point = new_point
	
	
var save_path := "user://player_data.json"

# To save data
func save() -> void:
	var data := {
		"name": Global.player_name,
		"points": Global.total_points,
	}

	var json_string := JSON.stringify(data)

  # We will need to open/create a new file for this data string
	var file_access := FileAccess.open(save_path, FileAccess.WRITE)
	if not file_access:
		print("An error happened while saving data: ", FileAccess.get_open_error())
		return

	file_access.store_line(json_string)
	file_access.close()
# To load data
func load() -> void:
	if not FileAccess.file_exists(save_path):
		return
	var file_access := FileAccess.open(save_path, FileAccess.READ)
	var json_string := file_access.get_line()
	file_access.close()

	var json := JSON.new()
	var error := json.parse(json_string)
	if error:
		print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return
  # We saved a dictionary, lets assume is a dictionary
	var data:Dictionary = json.data
	Global.player_name = data.get("name", "UNDEFINED")
	Global.total_points = data.get("points", 0)
	
func send_post_new_score():
	if Global.player_name == null:
		printerr("Will NOT send POST data with score due to invalid username")
		printerr("There might have been an error loading user_data file")
		return
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", _on_server_has_responded)
	var body = JSON.stringify({"username": Global.player_name, "score": Global.total_points})
	var headers = ["Content-Type: application/json", "Client-Secret: abc"] # CLIENT_SECRET should never be public! If leaked, ALL clients should be force-updated to use a new one
	http_request.request("http://127.0.0.1:8000/score", headers, HTTPClient.METHOD_POST, body)

func _on_server_has_responded(result, response_code, headers, body):
	var response = JSON.parse_string(body.get_string_from_utf8())
	print("Server response:")
	print(response)
