/* In this file:
 *
 * Plasma floor
 * Gold floor
 * Silver floor
 * Bananium floor
 * Diamond floor
 * Calorite floor
 * Uranium floor
 * Shuttle floor (Titanium)
 * Sand floors
 */

/turf/open/floor/mineral
	name = "mineral floor"
	icon_state = ""
	var/list/icons
	tiled_dirt = FALSE


/turf/open/floor/mineral/Initialize()
	if(!broken_states)
		broken_states = list("[initial(icon_state)]_dam")
	. = ..()
	icons = typelist("icons", icons)


/turf/open/floor/mineral/update_icon()
	if(!..())
		return 0
	if(!broken && !burnt)
		if( !(icon_state in icons) )
			icon_state = initial(icon_state)

//PLASMA

/turf/open/floor/mineral/plasma
	name = "plasma floor"
	icon_state = "plasma"
	floor_tile = /obj/item/stack/tile/mineral/plasma
	icons = list("plasma","plasma_dam")

/turf/open/floor/mineral/plasma/temperature_expose(datum/gas_mixture/air, exposed_temperature, exposed_volume)
	if(exposed_temperature > 300)
		PlasmaBurn(exposed_temperature)

/turf/open/floor/mineral/plasma/attackby(obj/item/W, mob/user, params)
	if(W.is_hot() > 300)//If the temperature of the object is over 300, then ignite
		message_admins("Plasma flooring was ignited by [ADMIN_LOOKUPFLW(user)] in [ADMIN_VERBOSEJMP(src)]")
		log_game("Plasma flooring was ignited by [key_name(user)] in [AREACOORD(src)]")
		ignite(W.is_hot())
		return
	..()

/turf/open/floor/mineral/plasma/proc/PlasmaBurn(temperature)
	make_plating()
	atmos_spawn_air("plasma=20;TEMP=[temperature]")

/turf/open/floor/mineral/plasma/proc/ignite(exposed_temperature)
	if(exposed_temperature > 300)
		PlasmaBurn(exposed_temperature)


//GOLD

/turf/open/floor/mineral/gold
	name = "gold floor"
	icon_state = "gold"
	floor_tile = /obj/item/stack/tile/mineral/gold
	icons = list("gold","gold_dam")

//SILVER

/turf/open/floor/mineral/silver
	name = "silver floor"
	icon_state = "silver"
	floor_tile = /obj/item/stack/tile/mineral/silver
	icons = list("silver","silver_dam")

//TITANIUM (shuttle)

/turf/open/floor/mineral/titanium
	name = "shuttle floor"
	icon_state = "titanium"
	floor_tile = /obj/item/stack/tile/mineral/titanium
	broken_states = list("titanium_dam1","titanium_dam2","titanium_dam3","titanium_dam4","titanium_dam5")

/turf/open/floor/mineral/titanium/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/mineral/titanium/yellow
	icon_state = "titanium_yellow"

/turf/open/floor/mineral/titanium/yellow/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/mineral/titanium/blue
	icon_state = "titanium_blue"

/turf/open/floor/mineral/titanium/blue/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/mineral/titanium/white
	icon_state = "titanium_white"

/turf/open/floor/mineral/titanium/white/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/mineral/titanium/purple
	icon_state = "titanium_purple"

/turf/open/floor/mineral/titanium/purple/airless
	initial_gas_mix = AIRLESS_ATMOS

// Old Titanium Floor

/turf/open/floor/mineral/titanium/old
	name = "tiled floor"
	icon_state = "titanium_old"
	floor_tile = /obj/item/stack/tile/mineral/titanium
	broken_states = list("titanium_dam1_old","titanium_dam2_old","titanium_dam3_old","titanium_dam4_old","titanium_dam5_old")
/turf/open/floor/mineral/titanium/old/airless
	initial_gas_mix = "TEMP=2.7"

/turf/open/floor/mineral/titanium/old/yellow
	icon_state = "titanium_yellow_old"
/turf/open/floor/mineral/titanium/old/yellow/airless
	initial_gas_mix = "TEMP=2.7"

/turf/open/floor/mineral/titanium/old/blue
	icon_state = "titanium_blue_old"
/turf/open/floor/mineral/titanium/old/blue/airless
	initial_gas_mix = "TEMP=2.7"

/turf/open/floor/mineral/titanium/old/white
	icon_state = "titanium_white_old"
/turf/open/floor/mineral/titanium/old/white/airless
	initial_gas_mix = "TEMP=2.7"

/turf/open/floor/mineral/titanium/old/purple
	icon_state = "titanium_purple_old"
/turf/open/floor/mineral/titanium/purple/airless
	initial_gas_mix = "TEMP=2.7"

//PLASTITANIUM (syndieshuttle)
/turf/open/floor/mineral/plastitanium
	name = "shuttle floor"
	icon_state = "plastitanium"
	floor_tile = /obj/item/stack/tile/mineral/plastitanium
	broken_states = list("plastitanium_dam1","plastitanium_dam2","plastitanium_dam3","plastitanium_dam4","plastitanium_dam5")

/turf/open/floor/mineral/plastitanium/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/mineral/plastitanium/red
	icon_state = "plastitanium_red"

/turf/open/floor/mineral/plastitanium/red/airless
	initial_gas_mix = AIRLESS_ATMOS

/turf/open/floor/mineral/plastitanium/red/brig
	name = "brig floor"

//BANANIUM

/turf/open/floor/mineral/bananium
	name = "bananium floor"
	icon_state = "bananium"
	floor_tile = /obj/item/stack/tile/mineral/bananium
	icons = list("bananium","bananium_dam")
	var/spam_flag = 0

/turf/open/floor/mineral/bananium/Entered(var/mob/living/L)
	.=..()
	if(!.)
		if(istype(L))
			squeak()

/turf/open/floor/mineral/bananium/attackby(obj/item/W, mob/user, params)
	.=..()
	if(!.)
		honk()

/turf/open/floor/mineral/bananium/attack_hand(mob/user)
	.=..()
	if(!.)
		honk()

/turf/open/floor/mineral/bananium/attack_paw(mob/user)
	.=..()
	if(!.)
		honk()

/turf/open/floor/mineral/bananium/proc/honk()
	if(spam_flag < world.time)
		playsound(src, 'sound/items/bikehorn.ogg', 50, 1)
		spam_flag = world.time + 20

/turf/open/floor/mineral/bananium/proc/squeak()
	if(spam_flag < world.time)
		playsound(src, "clownstep", 50, 1)
		spam_flag = world.time + 10

/turf/open/floor/mineral/bananium/airless
	initial_gas_mix = AIRLESS_ATMOS


//calorite floor - GS13

/turf/open/floor/mineral/calorite
	name = "Calorite floor"
	icon_state = "calorite"
	floor_tile = /obj/item/stack/tile/mineral/calorite
	icons = list("calorite","calorite_dam")
	var/last_event = 0
	var/active = null
	///How much fatness is added to the user upon crossing?
	var/fat_to_add = 50

/turf/open/floor/mineral/calorite/Entered(mob/living/carbon/M)
	if(!istype(M, /mob/living/carbon))
		return FALSE
	else
		M.adjust_fatness(fat_to_add, FATTENING_TYPE_ITEM)

// calorite floor, disguised version - GS13

/turf/open/floor/mineral/calorite/hide
	name = "Steel floor"
	icon_state = "calorite_hide"
	floor_tile = /obj/item/stack/tile/mineral/calorite/hide
	icons = list("calorite_hide","calorite_dam")

// calorite floor, powerful version - GS13

/turf/open/floor/mineral/calorite/strong
	name = "Infused calorite floor"
	icon_state = "calorite_strong"
	floor_tile = /obj/item/stack/tile/mineral/calorite/strong
	icons = list("calorite_strong","calorite_dam")

// calorite dance floor, groovy! - GS13

/turf/open/floor/mineral/calorite/dance
	name = "Infused calorite floor"
	icon_state = "calorite_dance"
	floor_tile = /obj/item/stack/tile/mineral/calorite/dance
	icons = list("calorite_dance","calorite_dam")

//DIAMOND

/turf/open/floor/mineral/diamond
	name = "diamond floor"
	icon_state = "diamond"
	floor_tile = /obj/item/stack/tile/mineral/diamond
	icons = list("diamond","diamond_dam")

//URANIUM

/turf/open/floor/mineral/uranium
	article = "a"
	name = "uranium floor"
	icon_state = "uranium"
	floor_tile = /obj/item/stack/tile/mineral/uranium
	icons = list("uranium","uranium_dam")
	var/last_event = 0
	var/active = null

/turf/open/floor/mineral/uranium/Entered(var/mob/AM)
	.=..()
	if(!.)
		if(istype(AM))
			radiate()

/turf/open/floor/mineral/uranium/attackby(obj/item/W, mob/user, params)
	.=..()
	if(!.)
		radiate()

/turf/open/floor/mineral/uranium/attack_hand(mob/user)
	.=..()
	if(!.)
		radiate()

/turf/open/floor/mineral/uranium/attack_paw(mob/user)
	.=..()
	if(!.)
		radiate()

/turf/open/floor/mineral/uranium/proc/radiate()
	if(!active)
		if(world.time > last_event+15)
			active = 1
			radiation_pulse(src, 10)
			for(var/turf/open/floor/mineral/uranium/T in orange(1,src))
				T.radiate()
			last_event = world.time
			active = 0
			return

// ALIEN ALLOY
/turf/open/floor/mineral/abductor
	name = "alien floor"
	icon_state = "alienpod1"
	floor_tile = /obj/item/stack/tile/mineral/abductor
	icons = list("alienpod1", "alienpod2", "alienpod3", "alienpod4", "alienpod5", "alienpod6", "alienpod7", "alienpod8", "alienpod9")
	baseturfs = /turf/open/floor/plating/abductor2

/turf/open/floor/mineral/abductor/Initialize()
	. = ..()
	icon_state = "alienpod[rand(1,9)]"

/turf/open/floor/mineral/abductor/break_tile()
	return //unbreakable

/turf/open/floor/mineral/abductor/burn_tile()
	return //unburnable

//SAND

/turf/open/floor/mineral/sandstone_floor
	name = "sandstone floor"
	icon_state = "sandstonef"
	floor_tile = /obj/item/stack/tile/mineral/sandstone
	icons = list("sandstonef","sandstonef_dam")

/turf/open/floor/mineral/crimsonstone_floor
	name = "crimson floor"
	icon_state = "crimsonstone"
	floor_tile = /obj/item/stack/tile/mineral/crimsonstone
	icons = list("crimsonstone","crimsonstone_dam")

/turf/open/floor/mineral/basaltstone_floor
	name = "basalt floor"
	icon_state = "basaltstone"
	floor_tile = /obj/item/stack/tile/mineral/basaltstone
	icons = list("basaltstone","basaltstone_dam")
