mob/player
	var
		attributes_initialized = FALSE

		attribute
			level
			stat_points

			health

			mind
			strength
			dexterity

			cheese

		obj/items
			equipped
			items[]

		obj/interface
			hotbar/hotbar

			cheese_score/cheese_score
			bar/safety_meter
			bar/health_bar

			scoreboard/scoreboard

			upgrades/upgrades

	proc
		LevelUp()
			if(level.Increment())
				stat_points.Increment()
				var attribute/choice = pick(mind, strength, dexterity)
				choice && stat_points.value && choice.Increment() && stat_points.Decrement()
