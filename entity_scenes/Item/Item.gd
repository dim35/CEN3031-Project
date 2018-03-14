extends Node2D

signal aquired

func _on_Body_body_entered( body ):
	if body.get_parent() == get_tree().get_root().get_node("World/PlayerSpawner/Container"):
		emit_signal("aquired")
		hide()
		$Body/CollisionShape2D.disabled = true