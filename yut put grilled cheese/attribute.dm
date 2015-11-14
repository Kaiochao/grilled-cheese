mob/player
	proc
		InitializeAttributes()
			if(!attributes_initialized)
				attributes_initialized = TRUE
				level		= new ("Level",			0, 10, 1)
				stat_points	= new ("Stat Points",	0, 1#INF)
				health		= new ("Health",		0, 24, "100%")
				mind		= new ("Mind",			0, 5)
				strength	= new ("Strength",		0, 5)
				dexterity	= new ("Dexterity",		0, 5)
				cheese		= new ("Cheese",		0)

attribute
	var
		name

		value
		minimum
		maximum

		obj/interface/tracker/tracker

	New(name = "unnamed attribute", minimum = -1#INF, maximum = 1#INF, value = 0)
		src.name = name
		src.minimum = min(minimum, maximum)
		src.maximum = max(minimum, maximum)
		if(istext(value))
			if(copytext(value, -1) == "%")
				var percent = text2num(value) / 100
				value = minimum + (maximum - minimum) * percent
		Set(value)

	proc
		Set(Value)
			value = min(max(Value, minimum), maximum)
			tracker && tracker.AttributeChanged(src)

		Get()
			return value

		ToText()
			return "[round(Percent() * 100, 1)]% ([round(value, 1)] / [round(maximum, 1)])"

		Increment()
			if(maximum - value >= 1)
				value++
				return TRUE
			return FALSE

		Decrement()
			if(value - minimum >= 1)
				value--
				return TRUE
			return FALSE

		Percent()
			return (value - minimum) / (maximum - minimum)
