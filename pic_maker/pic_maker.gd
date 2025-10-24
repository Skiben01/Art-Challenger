extends SubViewportContainer

## The flavour texts.
@export var wiki: WikiData : set = set_wiki

@onready var title: RichTextLabel = %Title
@onready var desc: RichTextLabel = %Description
@onready var series: Label = %Series
@onready var time_done: Label = %TimeDone

## Called on node entered
func _ready() -> void:
	# Calls setter
	wiki = wiki

## Sets wiki and appropriate Labels
func set_wiki(value: WikiData) -> void:
	if not is_node_ready():
		await ready
	
	wiki = value if value else WikiData.new()
	
	# Assigns Flavour Text
	title.text = wiki.name
	desc.text = wiki.description
	series.text = WikiData.Series.find_key(wiki.series).capitalize()
	
	
	# If there's time done, show time done.
	time_done.visible = wiki.recommended_time > 0.0
	if time_done.visible:
		time_done.text = "Is done after %s?:☐"
		
		# Adds time
		var current_time: int = floor(Time.get_unix_time_from_system()) + wiki.recommended_time
		current_time += ProjectSettings.get_setting_with_override("application/drawings/prep_time")
		time_done.text = time_done.text % Time.get_time_string_from_unix_time(current_time)
		time_done.text +=" (%s prep)" % Time.get_time_string_from_unix_time(
		ProjectSettings.get_setting_with_override("application/drawings/prep_time")
		)
