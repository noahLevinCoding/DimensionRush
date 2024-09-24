class_name GameStateMultiplayerOnlineConnection
extends State

@export var host_ip_label : Label
@export var host_ip_line_edit : LineEdit

var peer = ENetMultiplayerPeer.new()

func enter():
	resetUI()
	visible = true
	
func exit():
	visible = false

func resetUI():
	host_ip_label.text = "/"
	host_ip_line_edit.text = ""


func _on_host_button_up():
	close_connection()
	resetUI()
	
	GameManager.multiplayer_mode = GameManager.MULTIPLAYER_MODES.SERVER
	peer.create_server(135, 1)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	
	host_ip_label.text = IP.resolve_hostname(str(OS.get_environment("COMPUTERNAME")),1)


func _on_client_button_up():
	var host_ip = host_ip_line_edit.text
	
	close_connection()
	resetUI()
	
	
	GameManager.multiplayer_mode = GameManager.MULTIPLAYER_MODES.CLIENT
	peer.create_client(host_ip, 135)
	multiplayer.multiplayer_peer = peer

func _on_peer_connected(id = 1):
	print("Peer connected with id: " + str(id))


func _on_back_button_up():
	close_connection()
	state_transition.emit(self, "SelectOnePlayerControls")

func close_connection():
	if multiplayer.peer_connected.is_connected(_on_peer_connected):
		multiplayer.peer_connected.disconnect(_on_peer_connected)
	
	multiplayer.multiplayer_peer.close()
	multiplayer.multiplayer_peer = null
	
