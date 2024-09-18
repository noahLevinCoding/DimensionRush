class_name GameStateMultiplayerOnlineConnection
extends State

@export var host_ip_label : Label
@export var host_ip_line_edit : LineEdit

var peer = ENetMultiplayerPeer.new()

func enter():
	reset()
	visible = true
	
func exit():
	visible = false

func reset():
	#TODO clear connection
	host_ip_label.text = "/"
	host_ip_line_edit.text = ""


func _on_host_button_up():
	peer.create_server(135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	
	host_ip_label.text = IP.resolve_hostname(str(OS.get_environment("COMPUTERNAME")),1)


func _on_client_button_up():
	var host_ip = host_ip_line_edit.text 
	
	peer.create_client(host_ip, 135)
	multiplayer.multiplayer_peer = peer

func _on_peer_connected(id = 1):
	print("Peer connected with id: " + str(id))
