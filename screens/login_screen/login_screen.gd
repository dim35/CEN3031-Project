extends Control

export (PackedScene) var next_scene

var check = true # set to false to disable connecting to server

onready var username_field = get_node("Username_field")
onready var password_field = get_node("Password_field")
onready var address_field = get_node("Address_field")
onready var text_result = get_node("text_result")

var http = HTTPClient.new()
var HTTP_PORT = 443

var website_login_address = "https://ec2-54-175-123-188.compute-1.amazonaws.com"

func _init():
	pass

func _ready():
	$Username_field.grab_focus()
	print ("loaded login!")
	
# This has been connected from Button
func _on_Login_pressed():

	if check == true:
		var c = connect()
		if c == -1:
			text_result.bbcode_text = "Failed to connect to server"
			return
		if c == -2:
			text_result.bbcode_text = "Wrong username/password"
			return

		assert(!http.is_response_chunked())
		var bl = http.get_response_body_length()
		var chunk = http.read_response_body_chunk().get_string_from_ascii()
	
		var dict = {}
		dict = parse_json(chunk)
		global_player.session_token = dict["token"]
	else:
		# create fake session token if we are not checking for login
		global_player.session_token = randi() % 1000000 + 1
	
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


func _on_Signup_pressed():
	OS.shell_open(website_login_address)

func _process(delta):
	if(Input.is_action_pressed("ui_enter")):
		_on_Login_pressed()
