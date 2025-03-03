class_name StateMachine
extends Node

var states :Dictionary = {}
var current_state: State = null
var current_state_name : StringName = ""
var last_state_name : StringName = ""
@export var initial_state : State 

func _ready():
	# Append states and connect signals
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)
			child.back_transition.connect(change_state_back)
			child.force_state_transition.connect(force_change_state)
	
	#Initialize state
	if initial_state:
		current_state = initial_state
		current_state_name = current_state.get_name()
		initial_state.enter()
		
	
# Change to a new state
func change_state(source_state : State, new_state_name : StringName):
	
	if source_state != current_state:
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	last_state_name = current_state_name
	current_state_name = new_state_name	
	current_state = new_state
	
	new_state.enter()
	
	SignalManager.changed_game_state.emit()

# Return to the previous state
func change_state_back(source_state : State):
	if source_state != current_state:
		return
	
	if current_state:
		current_state.exit()
	
	var new_state = states.get(last_state_name.to_lower())
	if !new_state:
		return
	
	current_state_name = last_state_name	
	current_state = new_state
	
	new_state.enter()
	
	SignalManager.changed_game_state.emit()

# Force transition to a new state
func force_change_state(new_state_name : StringName):
	var new_state = states.get(new_state_name.to_lower())
	
	if !new_state:
		return
		
	if current_state == new_state:
		return
		
	if current_state:
		current_state.exit()
		
	last_state_name = current_state_name
	current_state_name = new_state_name	
	current_state = new_state
	
	new_state.enter()
	
	SignalManager.changed_game_state.emit()

func _process(delta):
	if current_state:
		current_state.update(delta)
		
func _physics_process(delta):
	if current_state:
		current_state.physics_update(delta)
		

func _input(_event):
	if Input.is_action_just_pressed("ui_cancel"):
		current_state.on_escape()
