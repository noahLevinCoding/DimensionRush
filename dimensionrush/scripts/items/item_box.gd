class_name ItemBox
extends Node2D

@export var items : Array[ItemBoxResource]
var item : ItemBoxResource

func _ready() -> void:
	randomize_item()
	
func randomize_item():
	var cumulative_odds = []
	var odds = 0
	
	for item in items:
		odds += item.odds
		cumulative_odds.append(odds)
	
	var random_value = randf() * odds
	
	for i in range(cumulative_odds.size()):
		if random_value <= cumulative_odds[i]:
			self.item = items[i]
			return
	
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		
		if not GameManager.is_online_multiplayer() or body.is_multiplayer_authority():
			if body.inventory.add_item(item.type):
				self.queue_free()
		else:
			if not body.inventory.has_item_no_sync:
				body.inventory.has_item_no_sync = true
				self.queue_free()
