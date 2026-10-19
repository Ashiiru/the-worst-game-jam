class_name ClientResource
extends Resource

@export var sprite : Texture2D
@export var name : String

#Every species of client except for Human has its own language, at the start of a run
#they are generated based on a cypher and remain consistent
@export var species : Species.Species

@export_multiline var dialogue : Array[String]

@export var order : Array[IngredientRes]

#The time the player will have to prepare this client's order. If more than half of this
#time is used the order result will be penalized, if time ends it is an instant fail
@export var patience : float

#These lines are said when the order is delivered depending on the performance
@export_multiline var dialogue_perfect : String
@export_multiline var dialogue_okay : String
@export_multiline var dialogue_bad : String
@export_multiline var dialogue_timeout : String
