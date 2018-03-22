extends Node2D

var occupied = false

func _ready():
	pass

func is_occupied():
	return occupied

func mark_occupied():
	occupied = true

func unmark_occupied():
	occupied = false
