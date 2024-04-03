extends TextureProgressBar

func _ready():
    Game.healthChanged.connect(update)
    update()

func update():
    value = Game.currentHealth * 100 / Game.maxHealth
