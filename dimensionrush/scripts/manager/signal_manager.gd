extends Node

signal close_connection

signal reset_multiplayer_authority

signal player_has_reached_end(is_upper: bool)
signal player_died(player: Player)

signal inventory_changed(is_upper : bool, has_item : bool, item_type : Item.ITEM_TYPE)
signal add_effect(source_is_upper : bool, destination_is_upper : bool, item_type : Item.ITEM_TYPE, is_synced : bool)

signal ping_other_player(player: Player)
signal ping_other_player_response(other_player: Player)

signal on_player_ready(player: Player)
signal on_player_action(player : Player)

signal changed_game_state
signal changed_game_mode
signal changed_game_seed
