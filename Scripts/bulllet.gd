extends CharacterBody3D

class_name Bullet

var wasShot = false
var _Speed = 5
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (wasShot):
		velocity = get_global_transform().basis.x * _Speed
		move_and_slide()
		velocity = Vector3.ZERO
	print("I EXIST!!!")
	
		
		
func _on_collision_polygon_3d_tree_entered(body: Node3D) -> void:
	print("Overlap")
	if body.has_method("Damage()"):
		body.Damage()
	else:
		print("object has no damage function, pretend we killed it")
		
	body.queue_free()
		
func DebugShot(Speed: float, Transform: Transform3D):
	self.visible = true
	print("object was shot")
	_Speed = Speed
	transform = Transform
	wasShot = true
