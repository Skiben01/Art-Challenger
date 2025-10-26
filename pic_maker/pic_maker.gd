extends SubViewport

## The flavour texts.
@export var wiki: WikiData : set = set_wiki

@onready var title: RichTextLabel = %Title
@onready var desc: RichTextLabel = %Description
@onready var series: Label = %Series
@onready var time_done: Label = %TimeDone
@onready var content: Control = %Content
@onready var share: Share = %Share

## Called on node entered
func _ready() -> void:
	get_child(0).custom_minimum_size = Vector2(
		ProjectSettings.get_setting_with_override("display/window/size/viewport_width"),
		ProjectSettings.get_setting_with_override("display/window/size/viewport_height"),
	)
	await get_tree().process_frame
	size = get_child(0).size
	
	# Calls setter
	wiki = wiki


## Sets wiki and appropriate Labels
func set_wiki(value: WikiData) -> void:
	if not is_node_ready():
		await ready
	
	# Remove old content
	if content.get_child_count():
		content.get_child(0).queue_free()
	
	if not is_node_ready():
		await ready
	wiki = value 

	if not wiki:
		return

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
	
	# Set's scene
	content.add_child(wiki.scene.instantiate())


## Returns [Texture2D] of the current screenshot.
func save_pict():
	if not is_node_ready():
		await ready
	
	await get_tree().process_frame
	
	var img: Image = get_texture().get_image()
	var file_name: String = "user://challengers/%s.png" % wiki.name.to_lower()
	DirAccess.open("user://").make_dir("challengers")
	img.save_png(file_name)
	
	# Shares the pict for easy access to Drawing Apps.
	share.share_image(file_name, "Challenge: %s" % wiki.name, "", "")
