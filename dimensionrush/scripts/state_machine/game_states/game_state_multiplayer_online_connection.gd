class_name GameStateMultiplayerOnlineConnection
extends State

@export var host_ip_line_edit : LineEdit
@export var host_button : CustomTextureButton
@export var join_button : CustomTextureButton

var peer = ENetMultiplayerPeer.new()

func _ready():
	SignalManager.close_connection.connect(close_connection)

func enter():
	close_connection()
	resetUI()
	visible = true
	GameManager.game_is_running = false
	
func exit():
	visible = false

func resetUI():
	host_ip_line_edit.text = ""
	host_ip_line_edit.editable = true
	
	host_button.disabled = false
	join_button.disabled = false
	
func disabledUI():
	host_ip_line_edit.editable = false
	
	host_button.disabled = true
	join_button.disabled = true


func _on_peer_connected(id = 1):
	if GameManager.is_server():
		GameManager.client_peer_id = id
	
	state_transition.emit(self, "SelectGameMode")

func _on_peer_disconnected(id = 1):
	force_state_transition.emit("MultiplayerOnlineConnection")
	

func close_connection():
	GameManager.multiplayer_mode = GameManager.MULTIPLAYER_MODES.NONE
	
	if multiplayer.peer_connected.is_connected(_on_peer_connected):
		multiplayer.peer_connected.disconnect(_on_peer_connected)
	if multiplayer.peer_disconnected.is_connected(_on_peer_disconnected):
		multiplayer.peer_disconnected.disconnect(_on_peer_disconnected)
	
	if multiplayer.has_multiplayer_peer():
		multiplayer.multiplayer_peer.close()
		multiplayer.multiplayer_peer = null
	

func _on_back_button_pressed() -> void:
	close_connection()
	state_transition.emit(self, "SelectOnePlayerControls")


func _on_host_button_pressed() -> void:
	close_connection()
	#resetUI()
	
	GameManager.multiplayer_mode = GameManager.MULTIPLAYER_MODES.SERVER
	peer.create_server(135, 1)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	
	host_ip_line_edit.text = IP.resolve_hostname(str(OS.get_environment("COMPUTERNAME")),1)

	#disabledUI()


func _on_join_button_pressed() -> void:
	var host_ip = host_ip_line_edit.text
	
	close_connection()
	#resetUI()
	
	
	GameManager.multiplayer_mode = GameManager.MULTIPLAYER_MODES.CLIENT
	peer.create_client(host_ip, 135)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)
	
	#disabledUI()

func _input(event: InputEvent) -> void:
	if visible:
		if Input.is_action_just_pressed("escape"):
			_on_back_button_pressed()
