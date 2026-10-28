class_name ClientProfile
extends Resource

@export var sprite : Texture2D
@export var name : String

@export var species : Enumerates.Species

#These lines are said when the order is delivered depending on the performance
@export_multiline var dialogue_perfect : String
@export_multiline var dialogue_okay : String
@export_multiline var dialogue_bad : String
@export_multiline var dialogue_timeout : String
