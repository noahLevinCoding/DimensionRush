extends Node

signal close_connection

signal reset_multiplayer_authority

signal player_has_reached_end(is_upper: bool)

signal inventory_changed(is_upper : bool, has_item : bool)
signal add_effect(source_is_upper : bool, destination_is_upper : bool, item_type : Item.ITEM_TYPE, is_synced : bool)

signal ping_other_player(player: Player)
signal ping_other_player_response(other_player: Player)
