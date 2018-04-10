extends "res://entity_scenes/AnimatedEntity.gd"

onready var explode_particles = preload("res://entity_scenes/entity_resources/ExplosionParticles.tscn")

func _ready():
	who = "projectile"
	$Soundfx.play()
	
remote func remote_move(p, d):
	position = p
	if d > 0:
		flip_state(true)
		$Particle1.rotation_degrees = 80
		$Particle1.position.x = -32
		$Particle2.rotation_degrees = 90
		$Particle2.position.x = -32
		$Particle3.rotation_degrees = 100
		$Particle3.position.x = -32
	else:
		flip_state(false)
		$Particle1.rotation_degrees = 280
		$Particle1.position.x = 32
		$Particle2.rotation_degrees = 270
		$Particle2.position.x = 32
		$Particle3.rotation_degrees = 260
		$Particle3.position.x = 32
		
remote func delete_me():
	var p = explode_particles.instance()
	p.position = position
	get_node("/root/World/entities").add_child(p)
	queue_free()