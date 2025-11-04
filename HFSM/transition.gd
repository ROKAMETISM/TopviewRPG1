class_name HTrans
extends Resource
enum Type {
	Enter,
	Exit
}
var operation_type := Type.Enter
var new_state : HState
func _init(state:HState, op_type:Type):
	new_state = state
	operation_type = op_type
