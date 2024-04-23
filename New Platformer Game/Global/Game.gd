extends Node

signal healthChanged

var currentHealth = 15
var maxHealth = 50
var Gold = 0

func hurtByEnemy(area):
    Game.currentHealth -= 2
    healthChanged.emit()
    if Game.currentHealth < 0:
        Game.currentHealth = Game.maxHealth
    
