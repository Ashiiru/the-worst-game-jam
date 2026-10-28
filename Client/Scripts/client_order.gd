class_name ClientOrder
extends Resource

#Every species of client except for Human has its own language, at the start of a run
#they are generated based on a cypher and remain consistent
@export var species : Enumerates.Species

@export_multiline var dialogue : String

@export var order : Array[IngredientRes]

#The time the player will have to prepare this client's order. If more than half of this
#time is used the order result will be penalized, if time ends it is an instant fail
@export var patience : float
