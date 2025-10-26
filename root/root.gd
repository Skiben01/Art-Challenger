extends Control

## The challenges list.
const LIST: String = "res://challengers/list/"

const BUTTON: Script = preload("./chall_button.gd")

@onready var list: VBoxContainer = %List
@onready var pic_maker := $PicMaker

## Called on entered tree
func _ready() -> void:
	var dir: DirAccess = DirAccess.open(LIST)
	for folder in dir.get_directories():
		var butt: BUTTON = BUTTON.new()
		butt.text = folder.capitalize()
		butt.wiki = ChallInfo.get_wiki(folder)
		list.add_child(butt)
		butt.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		butt.pressed.connect(_on_button_press.bind(butt))


## Saves the picture.
func _on_button_press(button: BUTTON) -> void:
	pic_maker.wiki = button.wiki
	
	await get_tree().process_frame
	pic_maker.save_pict()
