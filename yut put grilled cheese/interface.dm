mob/player
	proc
		InitializeInterface()
			health_bar = new /obj/interface/bar {
				name = "health"
				screen_loc = "west+1,north"
				color = "red"
				background_color = "black"
			} (health, 5, 1/2)

			hotbar = new /obj/interface/hotbar {
				screen_loc = "CENTER, 2"
			}
			hotbar.Build()

			cheese_score = new (cheese)

			client.screen.Add(health_bar, hotbar.slots)

obj/interface
	plane = 5

	tracker
		New(attribute/Attribute)
			..()
			Attribute.tracker = src
			AttributeChanged(Attribute)

		proc/AttributeChanged(attribute/Attribute)

	hotslot


	hotbar
		var
			obj/items/items[]
			obj/interface/hotslot/slots[]

		proc
			Build()
				if(!slots)
					slots = new (10)

				for(var/i in 1 to slots.len)
					var obj/interface/hotslot/slot = new
					slot.transform = matrix((i-1) * 32, 0, MATRIX_TRANSLATE)
					slot.layer = FLOAT_LAYER
					slot.screen_loc = screen_loc

			SetSlot(N, obj/items/Item)
				if(!items)
					items = new (slots.len)

				items[N] = Item
				UpdateSlot(N)

			SwapSlots(A, B)
				items.Swap(A, B)
				UpdateSlot(A)
				UpdateSlot(B)

			UpdateSlot(N)
				var obj/items/item = items[N]
				var obj/interface/hotslot/slot = slots[N]
				if(item)
					var image/item_image = image(item, layer = FLOAT_LAYER)
					slot.overlays = list(item_image)
				else
					slot.overlays.len = 0

	cheese_score
		parent_type = /obj/interface/tracker

		maptext_x = 32

		AttributeChanged(attribute/Attribute)
			maptext = "<text align=center valign=middle>[Attribute.value]"

	scoreboard


	upgrades


	bar
		parent_type = /obj/interface/tracker

		icon_state = "rect"
		dir = EAST

		var background_color

		// icon size scale
		var max_width = 1
		var max_height = 1

		var tmp/last_icon
		var icon_width
		var icon_height

		var last_percentage

		var tmp/image/background

		New(attribute/Attribute, MaxWidth, MaxHeight)
			max_width = MaxWidth
			max_height = MaxHeight
			..()

		proc/CheckIconSize()
			if(icon != last_icon)
				last_icon = icon
				var icon/i = icon(icon)
				icon_width = i.Width()
				icon_height = i.Height()

		// todo: handle other directions
		AttributeChanged(attribute/Attribute)

			CheckIconSize()

			if(!background)
				background = image(icon, icon_state, layer = FLOAT_LAYER)
				background.appearance_flags = RESET_COLOR | RESET_TRANSFORM
				var matrix/mat = new
				mat.Translate(icon_width / 2, icon_height / 2)
				mat.Scale(max_width + 2 / icon_width, max_height + 2 / icon_height)
				mat.Translate(-icon_width / 2 - 1, -icon_height / 2 - 1)
				background.transform = mat
				underlays += background

			if(background.color != background_color)
				underlays -= background
				background.color = background_color
				underlays += background

			var percent = Attribute.Percent()
			var matrix/mat = initial(transform)
			mat.Translate(icon_width / 2, icon_height / 2)
			mat.Scale(
				percent**!!(dir & HORIZONTAL) * max_width,
				percent**!!(dir & VERTICAL)   * max_height)
			mat.Translate(-icon_width / 2, -icon_height / 2)

			maptext_width = 1000
			maptext_height = 1000
			maptext_x = (icon_width - maptext_width) / 2
			maptext_y = (icon_height - maptext_height) / 2 - 32
			maptext = "<text align=center valign=middle>[Attribute]\n" + Attribute.ToText()

			var diff = !isnull(last_percentage) && percent - last_percentage
			last_percentage = percent

			animate(src, time = 10 * abs(diff), flags = ANIMATION_LINEAR_TRANSFORM,
				transform = mat)
