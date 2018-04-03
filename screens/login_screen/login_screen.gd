extends Control

export (PackedScene) var next_scene

var check = true # set to false to disable connecting to server

onready var username_field = get_node("Username_field")
onready var password_field = get_node("Password_field")
onready var address_field = get_node("Address_field")
onready var text_result = get_node("text_result")

var http = HTTPClient.new()
var HTTP_PORT = 443



func _init():
	pass

func _ready():
	print ("loaded login!")
	
# This has been connected from Button
func _on_Button_button_up():

	if check == true:
		var c = connect()
		if c == -1:
			text_result.bbcode_text = "Failed to connect to server"
			return
		if c == -2:
			text_result.bbcode_text = "Wrong username/password"
			return

	# figure out how to getresponse message when code is 200
	global_player.username = username_field.text
	global_player.server_ip = address_field.text

	get_tree().change_scene_to(next_scene)
	
	queue_free()
	
func connect():
	
	# connect to ip address
	http.connect_to_host(address_field.text, HTTP_PORT, true, false)
	
	# wait until connected
	while http.get_status() == HTTPClient.STATUS_CONNECTING or http.get_status() == HTTPClient.STATUS_RESOLVING:
		http.poll()
		print("Connecting........")
		OS.delay_msec(500)
	
	# if failed return
	if (http.get_status() != HTTPClient.STATUS_CONNECTED):
		return -1

	# send api request
	var query = http.query_string_from_dict({"username": username_field.text, "psw":password_field.text})
	var headers = [
		"Content-Type: application/x-www-form-urlencoded",
		"Content-Length: " + str(query.length())
	]
	http.request(HTTPClient.METHOD_POST, "/api/login", headers, query)
	
	# wait until finished requesting
	while http.get_status() == HTTPClient.STATUS_REQUESTING:
		http.poll()
		print ("Requesting...........")
		OS.delay_msec(300)
		
	# if failed return
	if(http.get_status() != HTTPClient.STATUS_BODY and http.get_status() != HTTPClient.STATUS_CONNECTED):
		return -2
		
	# verify error
	var code = http.get_response_code()
	if code == 200:
		return 200
	else:
		return -2

