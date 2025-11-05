class_name HState
extends Node
# Hold a reference to the parent so that it can be controlled by the state
@export var state_log := false
var parent:Node
var fsm:HFSM
func enter() -> void:
	if state_log:
		print("++entered : " + get_state_name())
	pass
func exit() -> void:
	if state_log:
		print("--exiting : " + get_state_name())
	pass
func process_input(_event: InputEvent) -> Array:
	return []
func process_frame(_delta: float) -> Array:
	return []
func process_physics(_delta: float) -> Array:
	return []
func get_current_states()->Array[HState]:
	return fsm._current_states
func is_active()->bool:
	return fsm._current_states.has(self)
func is_state_active(state:HState)->bool:
	return fsm._current_states.has(state)
func get_state_name()->String:
	return "BaseHStateName"
func _exit(output:Array, exit_state:HState)->void:
	output.append(HTrans.new(exit_state, HTrans.Type.Exit))
func _enter(output:Array, exit_state:HState)->void:
	output.append(HTrans.new(exit_state, HTrans.Type.Enter))
func _change(output:Array, new_state:HState)->void:
	output.append(HTrans.new(self, HTrans.Type.Exit))
	output.append(HTrans.new(new_state, HTrans.Type.Enter))
