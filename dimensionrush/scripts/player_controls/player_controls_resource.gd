class_name PlayerControlsResource
extends Resource

enum INPUT_DEVICE_TYPE {KEYBOARD, CONTROLLER}

@export var type : INPUT_DEVICE_TYPE 
@export var id : int

@export var item : String
@export var action : String

@export var left : String
@export var right : String
@export var up : String
@export var down : String

@export var jump : String = "fill"
@export var run : String = "fill"
@export var latch : String = "fill"
@export var dash : String = "fill"
@export var roll : String = "fill"
@export var twirl : String = "fill"
