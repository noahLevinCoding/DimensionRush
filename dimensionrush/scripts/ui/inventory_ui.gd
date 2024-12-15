class_name InventoryUi
extends Control

@export var is_upper   : bool
@export var background : ColorRect
@export var foreground : TextureRect

var blind_texture 			: Texture2D = preload("res://assets/items/blind.png")
var invert_controls_texture : Texture2D = preload("res://assets/items/invert_controls.png")
var speed_boost_texture 	: Texture2D	= preload("res://assets/items/speed_boost.png")
var steal_texture 			: Texture2D = preload("res://assets/items/steal.png")
var stun_texture 			: Texture2D = preload("res://assets/items/stun.png")



func _ready() -> void:
	SignalManager.inventory_changed.connect(_on_inventory_changed)

func set_item(has_item : bool, item_type: Item.ITEM_TYPE):
	foreground.visible = has_item
	
	match item_type:
		Item.ITEM_TYPE.BLIND:
			foreground.texture = blind_texture
		Item.ITEM_TYPE.INVERT_CONTROLS:
			foreground.texture = invert_controls_texture
		Item.ITEM_TYPE.SPEED_BOOST:
			foreground.texture = speed_boost_texture
		Item.ITEM_TYPE.STEAL_ACTIVE:
			foreground.texture = steal_texture
		Item.ITEM_TYPE.STUN:
			foreground.texture = stun_texture
		_:
			foreground.texture = null
	
func _on_inventory_changed(is_upper : bool, has_item : bool, item_type: Item.ITEM_TYPE):
	if is_upper == self.is_upper:
		set_item(has_item, item_type)
