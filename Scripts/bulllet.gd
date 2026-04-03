extends RigidBody3D

class_name Bullet

var wasShot = false
var Speed = 5
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (wasShot):
		var velocity = (transform.basis.x * -Speed)
		set_axis_velocity(velocity)
		
		
func _on_tree_entered(body: Node) -> void:
	if body.has_method("Damage()"):
		body.Damage()
	else:
		print("object has no damage function, pretend we killed it")
		
	body.queue_free()
		
