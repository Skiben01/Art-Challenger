extends Node

## Contains information about the Challengers.

const LIST: String = "res://challengers/list/"

## Returns [WikiData].
func get_wiki(challenge: String) -> WikiData:
	var folder_path: String = "%s/%s/" % [LIST, challenge]
	
	# Checks for validity
	var has: bool = DirAccess.open(LIST).dir_exists(challenge)
	if not has:
		push_error("%s is not a proper challenge folder" % challenge)
		return
	
	# Loads scene
	var wiki: WikiData = load(folder_path + "_wiki.tres")
	wiki.scene = load(folder_path + "_scene.tscn")
	assert(wiki.scene)
	
	return wiki
