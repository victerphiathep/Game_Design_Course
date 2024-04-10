extends CanvasLayer

# Assuming the dialogue Panel is named "DialoguePanel"
@onready var dialogue_panel = $TextboxContainer/DialoguePanel

func _ready():
    # Initially hide the dialogue panel
    dialogue_panel.visible = false
    # Call the function to show dialogue when the game starts
    show_dialogue("Where am I..?", 5.0)  # Display the text for 5 seconds

func show_dialogue(text: String, duration: float):
    dialogue_panel.get_node("Label").text = text  # Update the Label text
    dialogue_panel.visible = true  # Make the dialogue panel visible
    # Optionally hide the dialogue after a duration
    await get_tree().create_timer(duration).timeout
    dialogue_panel.visible = false

func _input(event):
    # Hide the dialogue if any key is pressed
    if event is InputEventKey and event.pressed:
        dialogue_panel.visible = false
