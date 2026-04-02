extends Node3D

@onready var Muzzle = $Muzzle
@export var BulletProjectile = preload("res://Objects/Bulllet.tscn")

@export var Speed: float = 5.0
# Called when the node enters the scene tree for the first time.

func Shoot():
	var Bullet = BulletProjectile.instantiate()
	Bullet.Speed = Speed
	Bullet.wasShot = true
