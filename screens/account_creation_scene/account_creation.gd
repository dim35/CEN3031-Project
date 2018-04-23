extends Control

export (PackedScene) var next_scene

var check = true # set to false to disable connecting to server

onready var username_field = get_node("Elements/Forms/Username_field")
onready var password_field = get_node("Elements/Forms/Password_field")
onready var password_field2 = get_node("Elements/Forms/Password_field2")
onready var address_field = get_node("Elements/Forms/Address_field")
onready var text_result = get_node("Elements/Forms/text_result")
onready var camera = get_node("Background/Camera")

var http = HTTPClient.new()
var HTTP_PORT = 443

var website_login_address = "https://ec2-54-175-123-188.compute-1.amazonaws.com"
func _init():
	pass

func _ready():
	username_field.grab_focus()
	print ("loaded account creation!")
	
# This has been connected from Button
func _on_Create_Account_pressed():
	var c = connect()

	if c == -1:
		text_result.bbcode_text = "Failed to connect to server"
		return
	if c == -2:
		text_result.bbcode_text = "Passwords do not match"
		return
	if c == -3:
		text_result.bbcode_text = "Username is already in use"
		return
	if c == -4:
		text_result.bbcode_text = "Password must be at least 3 characters long"
		return
	else:
		text_result.bbcode_text = "Account created successfully"
		return

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
	var query = http.query_string_from_dict({"username": username_field.text, "psw":password_field.text,  "psw-repeat":password_field2.text})
	var headers = [
		"Content-Type: application/x-www-form-urlencoded",
		"Content-Length: " + str(query.length())
	]
	http.request(HTTPClient.METHOD_POST, "/api/createaccount", headers, query)
	
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
	if code == 666:
		return -2
	if code == 667:
		return -3
	else:
		return -4

var isMenuActive = false

func _process(delta):
	camera.position.x += 2
	if(Input.is_action_pressed("ui_enter") and isMenuActive == false):
		_on_Create_Account_pressed()


func _on_Menu_hidemenu():
	if isMenuActive == false:
		isMenuActive = true
	else:
		username_field.grab_focus()
		isMenuActive = false


func _on_Return_Login_pressed():
	get_tree().change_scene("res://screens/login_screen/login_screen.tscn")
	queue_free()
