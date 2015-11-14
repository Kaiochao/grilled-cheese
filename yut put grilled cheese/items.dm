/*

	According to the design doc, items are "movable, able to be picked up and combined or equipped"

*/

mob/player
	Stat()
		statpanel("Contents", contents)

obj/items
	var
		tmp/mob/player/equipper

	MouseDrop(atom/over_object, src_location, over_location, src_control, over_control, params)
		if(params2list(params)["left"] && over_object && loc == usr && over_object.loc == usr && istype(over_object, /obj/items))
			var obj/items/other = over_object
			usr << "<i>Combining [src] with [other]</i>"
			other.Combine(src)

	Click(object, location, params)
		if(z && bounds_dist(src, usr) <= PICKUP_DISTANCE)
			loc = usr

	New(Loc)
		if(istype(loc, /mob/player))
			PickUp(loc)

	Del()
		if(istype(loc, /mob/player))
			Drop(loc)
		..()

	proc
		PickUp(mob/player/M)
			loc = M
			M << "<i>Picked up [src]</i>"

		Drop(mob/player/M)
			if(equipper)
				Unequip()
			loc = M.loc
			step_x = M.step_x
			step_y = M.step_y
			M << "<i>Dropped [src]</li>"

		Equip(mob/player/M)
			if(M.equipped && M.equipped != src)
				M.equipped.Unequip()
			M.equipped = src
			equipper = M
			M << "<i>Equipped [src]</i>"

		Unequip()
			equipper << "<i>Unequipped [src]</i>"
			equipper.equipped = null
			equipper = null

		Combine(obj/items/Other)

	knife
		icon_state = "rect"
		color = "silver"
		transform = shape_matrix(4, 16)

	bread
		icon_state = "rect"
		color = "#AD8D40"
		transform = shape_matrix(16, 8)

		var slices = 8

		Combine(obj/items/Other)
			if(istype(Other, /obj/items/knife))
				new /obj/items/bread_slice (loc)
				if(--slices <= 0)
					del src

	bread_slice

	cheese_wheel
		icon_state = "oval"
		color = "yellow"
		transform = shape_matrix(16, 16)

		var slices = 8

		Combine(obj/items/Other)
			if(istype(Other, /obj/items/knife))
				new /obj/items/cheese_slice (loc)
				if(--slices <= 0)
					del src

	cheese_slice
		icon_state = "rect"
		color = "yellow"
		transform = shape_matrix(12, 12)

	grilled_cheese

