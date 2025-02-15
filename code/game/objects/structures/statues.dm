/obj/structure/statue
	name = "statue"
	desc = "Placeholder. Yell at Firecage if you SOMEHOW see this."
	icon = 'icons/obj/statue.dmi'
	icon_state = ""
	density = TRUE
	anchored = FALSE
	max_integrity = 100
	var/oreAmount = 5
	var/material_drop_type = /obj/item/stack/sheet/metal
	var/impressiveness = 15
	CanAtmosPass = ATMOS_PASS_DENSITY

/obj/structure/statue/attackby(obj/item/W, mob/living/user, params)
	add_fingerprint(user)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(default_unfasten_wrench(user, W))
			return
		if(istype(W, /obj/item/weldingtool) || istype(W, /obj/item/gun/energy/plasmacutter))
			if(!W.tool_start_check(user, amount=0))
				return FALSE

			user.visible_message("[user] is slicing apart the [name].", \
								"<span class='notice'>You are slicing apart the [name]...</span>")
			if(W.use_tool(src, user, 40, volume=50))
				user.visible_message("[user] slices apart the [name].", \
									"<span class='notice'>You slice apart the [name]!</span>")
				deconstruct(TRUE)
			return
	return ..()

/obj/structure/statue/attack_hand(mob/living/user)
	. = ..()
	if(.)
		return
	user.changeNext_move(CLICK_CD_MELEE)
	add_fingerprint(user)
	if(!do_after(user, 20, target = src))
		return
	user.visible_message("[user] rubs some dust off [src].", \
						 "<span class='notice'>You take in [src], rubbing some dust off its surface.</span>")
	if(!ishuman(user)) // only humans have the capacity to appreciate art
		return
	var/totalimpressiveness = (impressiveness *(obj_integrity/max_integrity))
	switch(totalimpressiveness)
		if(GREAT_ART to 100)
			SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "artgreat", /datum/mood_event/artgreat)
		if (GOOD_ART to GREAT_ART)
			SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "artgood", /datum/mood_event/artgood)
		if (BAD_ART to GOOD_ART)
			SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "artok", /datum/mood_event/artok)
		if (0 to BAD_ART)
			SEND_SIGNAL(user, COMSIG_ADD_MOOD_EVENT, "artbad", /datum/mood_event/artbad)

/obj/structure/statue/deconstruct(disassembled = TRUE)
	if(!(flags_1 & NODECONSTRUCT_1))
		if(material_drop_type)
			var/drop_amt = oreAmount
			if(!disassembled)
				drop_amt -= 2
			if(drop_amt > 0)
				new material_drop_type(get_turf(src), drop_amt)
	qdel(src)

//////////////////////////////////////STATUES/////////////////////////////////////////////////////////////
////////////////////////uranium///////////////////////////////////

/obj/structure/statue/uranium
	max_integrity = 300
	light_range = 2
	material_drop_type = /obj/item/stack/sheet/mineral/uranium
	var/last_event = 0
	var/active = null
	impressiveness = 25 // radiation makes an impression

/obj/structure/statue/uranium/nuke
	name = "statue of a nuclear fission explosive"
	desc = "This is a grand statue of a Nuclear Explosive. It has a sickening green colour."
	icon_state = "nuke"

/obj/structure/statue/uranium/eng
	name = "Statue of an engineer"
	desc = "This statue has a sickening green colour."
	icon_state = "eng"

/obj/structure/statue/uranium/attackby(obj/item/W, mob/user, params)
	radiate()
	return ..()

/obj/structure/statue/uranium/Bumped(atom/movable/AM)
	radiate()
	..()

/obj/structure/statue/uranium/attack_hand(mob/user)
	radiate()
	. = ..()

/obj/structure/statue/uranium/attack_paw(mob/user)
	radiate()
	. = ..()

/obj/structure/statue/uranium/proc/radiate()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			radiation_pulse(src, 30)
			last_event = world.time
			active = null
			return
	return

////////////////////////////plasma///////////////////////////////////////////////////////////////////////

/obj/structure/statue/plasma
	max_integrity = 200
	material_drop_type = /obj/item/stack/sheet/mineral/plasma
	desc = "This statue is suitably made from plasma."
	impressiveness = 20

/obj/structure/statue/plasma/scientist
	name = "statue of a scientist"
	icon_state = "sci"

/obj/structure/statue/plasma/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		PlasmaBurn(exposed_temperature)


/obj/structure/statue/plasma/bullet_act(obj/item/projectile/Proj)
	var/burn = FALSE
	if(!(Proj.nodamage) && Proj.damage_type == BURN && !QDELETED(src))
		burn = TRUE
	if(burn)
		var/turf/T = get_turf(src)
		if(Proj.firer)
			message_admins("Plasma statue ignited by [ADMIN_LOOKUPFLW(Proj.firer)] in [ADMIN_VERBOSEJMP(T)]")
			log_game("Plasma statue ignited by [key_name(Proj.firer)] in [AREACOORD(T)]")
		else
			message_admins("Plasma statue ignited by [Proj]. No known firer, in [ADMIN_VERBOSEJMP(T)]")
			log_game("Plasma statue ignited by [Proj] in [AREACOORD(T)]. No known firer.")
		PlasmaBurn(2500)
	..()

/obj/structure/statue/plasma/attackby(obj/item/W, mob/user, params)
	if(W.is_hot() > 300 && !QDELETED(src))//If the temperature of the object is over 300, then ignite
		var/turf/T = get_turf(src)
		message_admins("Plasma statue ignited by [ADMIN_LOOKUPFLW(user)] in [ADMIN_VERBOSEJMP(T)]")
		log_game("Plasma statue ignited by [key_name(user)] in [AREACOORD(T)]")
		ignite(W.is_hot())
	else
		return ..()

/obj/structure/statue/plasma/proc/PlasmaBurn(exposed_temperature)
	if(QDELETED(src))
		return
	atmos_spawn_air("plasma=[oreAmount*10];TEMP=[exposed_temperature]")
	deconstruct(FALSE)

/obj/structure/statue/plasma/proc/ignite(exposed_temperature)
	if(exposed_temperature > 300)
		PlasmaBurn(exposed_temperature)

//////////////////////gold///////////////////////////////////////

/obj/structure/statue/gold
	max_integrity = 300
	material_drop_type = /obj/item/stack/sheet/mineral/gold
	desc = "This is a highly valuable statue made from gold."
	impressiveness = 30

/obj/structure/statue/gold/hos
	name = "statue of the head of security"
	icon_state = "hos"

/obj/structure/statue/gold/hop
	name = "statue of the head of personnel"
	icon_state = "hop"

/obj/structure/statue/gold/cmo
	name = "statue of the chief medical officer"
	icon_state = "cmo"

/obj/structure/statue/gold/ce
	name = "statue of the chief engineer"
	icon_state = "ce"

/obj/structure/statue/gold/rd
	name = "statue of the research director"
	icon_state = "rd"

//////////////////////////silver///////////////////////////////////////

/obj/structure/statue/silver
	max_integrity = 300
	material_drop_type = /obj/item/stack/sheet/mineral/silver
	desc = "This is a valuable statue made from silver."
	impressiveness = 25

/obj/structure/statue/silver/md
	name = "statue of a medical officer"
	icon_state = "md"

/obj/structure/statue/silver/janitor
	name = "statue of a janitor"
	icon_state = "jani"

/obj/structure/statue/silver/sec
	name = "statue of a security officer"
	icon_state = "sec"

/obj/structure/statue/silver/secborg
	name = "statue of a security cyborg"
	icon_state = "secborg"

/obj/structure/statue/silver/medborg
	name = "statue of a medical cyborg"
	icon_state = "medborg"

/////////////////////////diamond/////////////////////////////////////////

/obj/structure/statue/diamond
	max_integrity = 1000
	material_drop_type = /obj/item/stack/sheet/mineral/diamond
	desc = "This is a very expensive diamond statue."
	impressiveness = 60

/obj/structure/statue/diamond/captain
	name = "statue of THE captain."
	icon_state = "cap"

/obj/structure/statue/diamond/ai1
	name = "statue of the AI hologram."
	icon_state = "ai1"

/obj/structure/statue/diamond/ai2
	name = "statue of the AI core."
	icon_state = "ai2"

////////////////////////bananium///////////////////////////////////////

/obj/structure/statue/bananium
	max_integrity = 300
	material_drop_type = /obj/item/stack/sheet/mineral/bananium
	desc = "A bananium statue with a small engraving:'HOOOOOOONK'."
	var/spam_flag = 0
	impressiveness = 65

/obj/structure/statue/bananium/clown
	name = "statue of a clown"
	icon_state = "clown"

/obj/structure/statue/bananium/Bumped(atom/movable/AM)
	honk()
	..()

/obj/structure/statue/bananium/attackby(obj/item/W, mob/user, params)
	honk()
	return ..()

/obj/structure/statue/bananium/attack_hand(mob/user)
	honk()
	. = ..()

/obj/structure/statue/bananium/attack_paw(mob/user)
	honk()
	..()

/obj/structure/statue/bananium/proc/honk()
	if(!spam_flag)
		spam_flag = 1
		playsound(src.loc, 'sound/items/bikehorn.ogg', 50, 1)
		spawn(20)
			spam_flag = 0

/////////////////////sandstone/////////////////////////////////////////

/obj/structure/statue/sandstone
	max_integrity = 50
	material_drop_type = /obj/item/stack/sheet/mineral/sandstone

/obj/structure/statue/sandstone/assistant
	name = "statue of an assistant"
	desc = "A cheap statue of sandstone for a greyshirt."
	icon_state = "assist"


/obj/structure/statue/sandstone/venus //call me when we add marble i guess
	name = "statue of a pure maiden"
	desc = "An ancient marble statue. The subject is depicted with a floor-length braid and is wielding a toolbox. By Jove, it's easily the most gorgeous depiction of a woman you've ever seen. The artist must truly be a master of his craft. Shame about the broken arm, though."
	icon = 'icons/obj/statuelarge.dmi'
	icon_state = "venus"

/obj/structure/statue/sandstone/abs
	max_integrity = 300
	anchored = TRUE
	name = "ancient statue"
	desc = "An ancient statue, representing one of the gods. It almost seems like it's alive."
	icon = 'icons/obj/statue_egypty.dmi'
	icon_state = "abs"

/////////////////////snow/////////////////////////////////////////

/obj/structure/statue/snow
	max_integrity = 50
	material_drop_type = /obj/item/stack/sheet/mineral/snow

/obj/structure/statue/snow/snowman
	name = "snowman"
	desc = "Several lumps of snow put together to form a snowman."
	icon_state = "snowman"

/////////////////////V Statues from GS13 V/////////////////////////////////////////

/obj/structure/statue/blueberry
	max_integrity = 500

/obj/structure/statue/blueberry
	name = "blueberry statue"
	desc = "A statue resembling a poor humanoid creature shaped like a ball."
	icon_state = "blueberry"


//////////////////////////////CALORITE - GS13///////////////////////////////

/obj/structure/statue/calorite
	max_integrity = 400
	material_drop_type = /obj/item/stack/sheet/mineral/calorite

/obj/structure/statue/calorite/fatty
	name = "Fatty statue"
	desc = "A statue of a well-rounded fatso."
	icon_state = "fatty"
	var/active = null
	var/last_event = 0

/obj/structure/statue/calorite/fatty/proc/beckon()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			for(var/mob/living/carbon/human/M in orange(3,src))
				to_chat(M, "<span class='warning'>You feel the statue calling to you, urging you to touch it...</span>")
			last_event = world.time
			active = null
			return
	return

/obj/structure/statue/calorite/fatty/proc/statue_fatten(mob/living/carbon/M)
	if(!M.adjust_fatness(20, FATTENING_TYPE_ITEM))
		to_chat(M, "<span class='warning'>Nothing happens.</span>")
		return 

	if(M.fatness < FATNESS_LEVEL_FATTER)
		to_chat(M, "<span class='warning'>The moment your hand meets the statue, you feel a little warmer...</span>")
	else if(M.fatness < FATNESS_LEVEL_OBESE)
		to_chat(M, "<span class='warning'>Upon each poke of the statue, you feel yourself get a little heavier.</span>")
	else if(M.fatness < FATNESS_LEVEL_EXTREMELY_OBESE)
		to_chat(M, "<span class='warning'>With each touch you keep getting fatter... But the fatter you grow, the more enticed you feel to poke the statue.</span>")
	else if(M.fatness < FATNESS_LEVEL_BARELYMOBILE)
		to_chat(M, "<span class='warning'>The world around you blurs as you focus on prodding the statue, your waistline widening further...</span>")
	else if(M.fatness < FATNESS_LEVEL_IMMOBILE)
		to_chat(M, "<span class='warning'>A whispering voice gently compliments your massive body, your own mind begging to touch the statue more.</span>")
	else
		to_chat(M, "<span class='warning'>You can barely reach the statue past your floor-covering stomach! And yet, it still calls to you...</span>")

/obj/structure/statue/calorite/fatty/Bumped(atom/movable/AM)
	beckon()
	..()

/obj/structure/statue/calorite/fatty/Crossed(var/mob/AM)
	.=..()
	if(!.)
		if(istype(AM))
			beckon()

/obj/structure/statue/calorite/fatty/Moved(atom/movable/AM)
	beckon()
	..()

/obj/structure/statue/calorite/fatty/attackby(obj/item/W, mob/living/carbon/M, params)
	statue_fatten(M)

/obj/structure/statue/calorite/fatty/attack_hand(mob/living/carbon/M)
	statue_fatten(M)

/obj/structure/statue/calorite/fatty/attack_paw(mob/living/carbon/M)
	statue_fatten(M)
