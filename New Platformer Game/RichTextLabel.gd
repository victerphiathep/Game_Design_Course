extends RichTextLabel


var example_text = "Welcome to Eldritch Fields\n and this is a new line."

func _ready() -> void:
    scroll_text(example_text)
    
func scroll_text(input_text:String) -> void:
    visible_characters = 0
    text = input_text
    
    for i in text.length():
        visible_characters += 1
        await get_tree().create_timer(0.1).timeout
        
