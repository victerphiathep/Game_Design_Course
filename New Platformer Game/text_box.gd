extends CanvasLayer

onready var textbox_container = $Textbox Container
onready var start_symbol = $TextboxContainer/MarginContainer/HBoxContainer/Start
onready var end_symbol = $TextboxContainer/MarginContainer/HBoxContainer/End
onready var label = $TextboxContainer/MarginContainer/HboxContainer/Label3

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_textbox() # Replace with function body.
	add_text("This text is going to be added")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func hide_textbox():
	start_symbol.text = ""
	end_symbol.text = ""
	label.text = ""
	
func show_textbox():
	start_symbol.text =  "*"
	textbox_container.show()

func add_text(next_text):
	label.text = next_text
	show_textbox()
	var tween = get_tree().create_tween()
	tween.tween_property(label, "visible_characters", [244], len(next_text) * CHAR_READ_RATE).from(0).finished
	tween.connect("finished", on_tween_finished)
	
	
func on_tween_finished():
	end_symbol.text = "<-"
