/*

	The current demo is just showing off how the HUD bar tracks the player's health attribute.

	Attributes are initialized in attribute.dm. It's pretty much complete.

	The interface is set up in interface.dm. It's mostly incomplete.

*/

world
	fps = FPS
	maxx = 20
	maxy = 15
	view = "20x15"

	area = /area/invisible
	turf = /turf/grass
	mob = /mob/player

	New()
		..()
		new /obj/items/knife (locate(10, 5, 1))
		new /obj/items/bread (locate(9, 5, 1))
		new /obj/items/cheese_wheel (locate(8, 5, 1))

area/invisible
	invisibility = 101

turf/grass
	icon_state = "rect"
	color = "green"

mob/player
	icon_state = "oval"
	color = "blue"
	step_size = 3

	Login()
		loc = locate(5, 5, 1)
		InitializeAttributes()
		InitializeInterface()

	verb/set_health(Health as num)
		health.Set(Health)
