extends Node

signal healthChanged

var currentHealth = 10
var maxHealth = 10
var Gold = 0

func hurtByEnemy(area):
	Game.currentHealth -= 2
	healthChanged.emit()
	if Game.currentHealth < 0:
		Game.currentHealth = Game.maxHealth
	
