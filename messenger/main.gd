extends Control


const PORT := 7777
const MAX_CLIENTS := 4

@onready var status_label: Label = $MarginContainer/VBoxContainer/StatusLabel
@onready var ip_input: LineEdit = $MarginContainer/VBoxContainer/IPInput
@onready var chat_box: TextEdit = $MarginContainer/VBoxContainer/ChatBox
@onready var message_input: LineEdit = $MarginContainer/VBoxContainer/MessageRow/MessageInput

@onready var host_button: Button = $MarginContainer/VBoxContainer/Buttons/HostButton
@onready var connect_button: Button = $MarginContainer/VBoxContainer/Buttons/ConnectButton
@onready var send_button: Button = $MarginContainer/VBoxContainer/MessageRow/SendButton


func _ready():
	host_button.pressed.connect(start_server)
	connect_button.pressed.connect(connect_to_server)
	send_button.pressed.connect(send_message)

	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

	multiplayer.connected_to_server.connect(_on_connected_to_server)
	multiplayer.connection_failed.connect(_on_connection_failed)
	multiplayer.server_disconnected.connect(_on_server_disconnected)

	status_label.text = "Not connected"

func start_server():
	var peer := ENetMultiplayerPeer.new()

	var error := peer.create_server(PORT, MAX_CLIENTS)

	if error != OK:
		status_label.text = "Failed to create server"
		return

	multiplayer.multiplayer_peer = peer
	
	#DisplayServer.window_set_title("Server - 1")
	get_window().title = "Server - 1"

	status_label.text = "Server started on port %d" % PORT

	add_chat_message("Server started")
	


func connect_to_server():
	var ip := ip_input.text.strip_edges()

	if ip.is_empty():
		status_label.text = "Enter server IP"
		return

	var peer := ENetMultiplayerPeer.new()

	var error := peer.create_client(ip, PORT)

	if error != OK:
		status_label.text = "Connection failed"
		return

	multiplayer.multiplayer_peer = peer

	status_label.text = "Connecting to %s..." % ip


func send_message():
	var message := message_input.text.strip_edges()

	if message.is_empty():
		return

	var sender_id := multiplayer.get_unique_id()

	receive_message.rpc(
		sender_id,
		message
	)

	message_input.clear()


@rpc("any_peer", "call_local", "reliable")
func receive_message(sender_id: int, message: String):
	add_chat_message(
		"[%s]: %s" % [sender_id, message]
	)


func add_chat_message(message: String):
	chat_box.text += message + "\n"


func _on_peer_connected(id: int):
	add_chat_message("Peer connected: %s" % id)

	status_label.text = "Connected"


func _on_peer_disconnected(id: int):
	add_chat_message("Peer disconnected: %s" % id)


func _on_connected_to_server():
	var id := multiplayer.get_unique_id()

	get_window().title = "Client - %s" % id

	status_label.text = "Connected to server"

	add_chat_message(
		"Connected to server as peer %s" % id
	)

func _on_connection_failed():
	status_label.text = "Connection failed"
	DisplayServer.window_set_title("Client - Connection Failed")

func _on_server_disconnected():
	status_label.text = "Server disconnected"
	DisplayServer.window_set_title("Client - Disconnected")
