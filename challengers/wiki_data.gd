class_name WikiData extends Resource

## Contains the flavour-text
##
## Each detail will be displayed on the top of the challenge.

enum Series {
	NONE,
	MICHEAL_HAMPTOM,
	SCOTT_ROBERTSON,
}

@export var name: String
@export_multiline var description: String
@export var series: Series 

## in seconds.
@export var recommended_time: int = -100

## Loads at runtime.
var scene: PackedScene
