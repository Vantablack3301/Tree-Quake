extends Node3D

@export var Muzzle: Node3D
@export var BulletProjectile: PackedScene

@export var Speed: float = 5.0
# Called when the node enters the scene tree for the first time.

func Shoot():
	var Bullet = BulletProjectile.instantiate()
	get_tree().root.add_child(Bullet)
	Bullet.DebugShot(Speed, global_transform)
	#print("bulletShot")
