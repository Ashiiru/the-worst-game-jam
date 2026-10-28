class_name Enumerates

enum Species {HUMAN, GLORPI, CONSTRUCT}

static func get_species_font_path(species : Species) -> String:
	match species:
		Species.GLORPI:
			return "res://TextFonts/Alien_lines_1.9.ttf"
		Species.CONSTRUCT:
			return "res://TextFonts/Monocracy Cuts and Clips.ttf"
		_:
			return "res://TextFonts/SplendidN.ttf"

enum Locations {MAIN, ASSEMBLY, HOUSE, SHOP}
