class_name Switch
extends Node2D


@export var switchables : Array[Switchable]

var player_in_area : Player = null


func _ready() -> void:
	SignalManager.on_player_action.connect(_on_player_action)

func _on_player_action(player : Player):
	if player == player_in_area:
		for switchable in switchables:
			switchable.switch()

func _on_area_body_entered(body: Node2D) -> void:
	if body is Player:
		player_in_area = body


func _on_area_body_exited(body: Node2D) -> void:
	if body is Player:
		player_in_area = null
