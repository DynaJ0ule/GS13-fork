//we'll put funky non-toxic chems here

//fattening chem
/datum/reagent/consumable/lipoifier
	name = "Lipoifier"
	description = "A very potent chemical that causes those that ingest it to build up fat cells quickly."
	taste_description = "lard"
	reagent_state = LIQUID
	color = "#e2e1b1"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/consumable/lipoifier/on_mob_life(mob/living/carbon/M)
	M.adjust_fatness(10, FATTENING_TYPE_CHEM)
	return ..()
