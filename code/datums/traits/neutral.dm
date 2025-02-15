//traits with no real impact that can be taken freely
//MAKE SURE THESE DO NOT MAJORLY IMPACT GAMEPLAY. those should be positive or negative traits.

/datum/quirk/no_taste
	name = "Ageusia"
	desc = "You can't taste anything! Toxic food will still poison you."
	value = 0
	category = CATEGORY_FOOD
	mob_trait = TRAIT_AGEUSIA
	gain_text = "<span class='notice'>You can't taste anything!</span>"
	lose_text = "<span class='notice'>You can taste again!</span>"
	medical_record_text = "Patient suffers from ageusia and is incapable of tasting food or reagents."

/datum/quirk/vegetarian
	name = "Vegetarian"
	desc = "You find the idea of eating meat morally and physically repulsive."
	value = 0
	category = CATEGORY_FOOD
	gain_text = "<span class='notice'>You feel repulsion at the idea of eating meat.</span>"
	lose_text = "<span class='notice'>You feel like eating meat isn't that bad.</span>"
	medical_record_text = "Patient reports a vegetarian diet."

/datum/quirk/vegetarian/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.liked_food &= ~MEAT
	species.disliked_food |= MEAT

/datum/quirk/vegetarian/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		if(initial(species.liked_food) & MEAT)
			species.liked_food |= MEAT
		if(!initial(species.disliked_food) & MEAT)
			species.disliked_food &= ~MEAT

/datum/quirk/pineapple_liker
	name = "Ananas Affinity"
	desc = "You find yourself greatly enjoying fruits of the ananas genus. You can't seem to ever get enough of their sweet goodness!"
	value = 0
	category = CATEGORY_FOOD
	gain_text = "<span class='notice'>You feel an intense craving for pineapple.</span>"
	lose_text = "<span class='notice'>Your feelings towards pineapples seem to return to a lukewarm state.</span>"
	medical_record_text = "Patient demonstrates a pathological love of pineapple."

/datum/quirk/pineapple_liker/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.liked_food |= PINEAPPLE

/datum/quirk/pineapple_liker/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.liked_food &= ~PINEAPPLE

/datum/quirk/pineapple_hater
	name = "Ananas Aversion"
	desc = "You find yourself greatly detesting fruits of the ananas genus. Serious, how the hell can anyone say these things are good? And what kind of madman would even dare putting it on a pizza!?"
	value = 0
	category = CATEGORY_FOOD
	gain_text = "<span class='notice'>You find yourself pondering what kind of idiot actually enjoys pineapples...</span>"
	lose_text = "<span class='notice'>Your feelings towards pineapples seem to return to a lukewarm state.</span>"
	medical_record_text = "Patient is correct to think that pineapple is disgusting."

/datum/quirk/pineapple_hater/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.disliked_food |= PINEAPPLE

/datum/quirk/pineapple_hater/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.disliked_food &= ~PINEAPPLE

/datum/quirk/deviant_tastes
	name = "Deviant Tastes"
	desc = "You dislike food that most people enjoy, and find delicious what they don't."
	value = 0
	category = CATEGORY_FOOD
	gain_text = "<span class='notice'>You start craving something that tastes strange.</span>"
	lose_text = "<span class='notice'>You feel like eating normal food again.</span>"
	medical_record_text = "Patient demonstrates irregular nutrition preferences."

/datum/quirk/deviant_tastes/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	var/liked = species.liked_food
	species.liked_food = species.disliked_food
	species.disliked_food = liked

/datum/quirk/deviant_tastes/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.liked_food = initial(species.liked_food)
		species.disliked_food = initial(species.disliked_food)

/datum/quirk/monochromatic
	name = "Monochromacy"
	desc = "You suffer from full colorblindness, and perceive nearly the entire world in blacks and whites."
	value = 0
	category = CATEGORY_GAMEPLAY
	medical_record_text = "Patient is afflicted with almost complete color blindness."

/datum/quirk/monochromatic/add()
	quirk_holder.add_client_colour(/datum/client_colour/monochrome)

/datum/quirk/monochromatic/post_add()
	if(quirk_holder.mind.assigned_role == "Detective")
		to_chat(quirk_holder, "<span class='boldannounce'>Mmm. Nothing's ever clear on this station. It's all shades of gray...</span>")
		quirk_holder.playsound_local(quirk_holder, 'sound/ambience/ambidet1.ogg', 50, FALSE)

/datum/quirk/monochromatic/remove()
	if(quirk_holder)
		quirk_holder.remove_client_colour(/datum/client_colour/monochrome)

/datum/quirk/crocrin_immunity
	name = "Crocin Immunity"
	desc = "You're one of the few people in the galaxy who are genetically immune to Crocin and Hexacrocin products and their addictive properties! However, you can still get brain damage from Hexacrocin addiction."
	mob_trait = TRAIT_CROCRIN_IMMUNE
	value = 0
	category = CATEGORY_SEXUAL
	gain_text = "<span class='notice'>You feel more prudish.</span>"
	lose_text = "<span class='notice'>You don't feel as prudish as before.</span>"
	medical_record_text = "Patient exhibits a special gene that makes them immune to Crocin and Hexacrocin."

/datum/quirk/assblastusa
	name = "Buns of Steel"
	desc = "You've never skipped ass day. With this trait, you are completely immune to all forms of ass slapping and anyone who tries to slap your rock hard ass usually gets a broken hand."
	mob_trait = TRAIT_ASSBLASTUSA
	value = 0
	category = CATEGORY_SEXUAL
	medical_record_text = "Patient never skipped ass day."
	gain_text = "<span class='notice'>Your ass rivals those of golems.</span>"
	lose_text = "<span class='notice'>Your butt feels more squishy and slappable.</span>"

/datum/quirk/headpat_slut
	name = "Headpat Slut"
	desc = "You like headpats, alot, maybe even a little bit too much. Headpats give you a bigger mood boost and cause arousal"
	mob_trait = TRAIT_HEADPAT_SLUT
	value = 0
	category = CATEGORY_SEXUAL
	medical_record_text = "Patient seems overly affectionate."

/datum/quirk/headpat_hater
	name = "Distant"
	desc = "You don't seem to show much care for being touched. Whether it's because you're reserved or due to self control, you won't wag your tail outside of your own control should you possess one."
	mob_trait = TRAIT_DISTANT
	value = 0
	category = CATEGORY_SEXUAL	//Any better place to put it? Doesn't really affect gameplay
	medical_record_text = "Patient cares little with or dislikes being touched."

/datum/quirk/weak_legs
	name = "Weak legs"
	desc = "Your legs can't handle the heaviest of charges. Being too fat will render you unable to move at all."
	mob_trait = TRAIT_WEAKLEGS
	value = 0
	category = CATEGORY_SEXUAL
	medical_record_text = "Patient's legs seem to lack strength"

/datum/quirk/SpawnWithWheelchair
	name = "Mobility Assistance"
	desc = "After your last failed fitness test, you were advised to start using a hoverchair"
	category = CATEGORY_MOVEMENT
/datum/quirk/SpawnWithWheelchair/on_spawn()
	if(quirk_holder.buckled) // Handle late joins being buckled to arrival shuttle chairs.
		quirk_holder.buckled.unbuckle_mob(quirk_holder)

	var/turf/T = get_turf(quirk_holder)
	var/obj/structure/chair/spawn_chair = locate() in T

	var/obj/vehicle/ridden/wheelchair/wheels = new(T)
	if(spawn_chair) // Makes spawning on the arrivals shuttle more consistent looking
		wheels.setDir(spawn_chair.dir)

	wheels.buckle_mob(quirk_holder)

/datum/quirk/trashcan //for when you are literally flint (Stolen from hyper)
	name = "Trashcan"
	desc = "You are able to consume and digest trash."
	value = 0
	gain_text = "<span class='notice'>You feel like munching on a can of soda.</span>"
	lose_text = "<span class='notice'>You no longer feel like you should be eating trash.</span>"
	mob_trait = TRAIT_TRASHCAN
	category = CATEGORY_FOOD
	medical_record_text = "Patient has been observed eating inedable garbage."

/datum/quirk/universal_diet
	name = "Universal diet"
	desc = "You are fine with eating just about anything normally edible, you have no strong dislikes in food. Toxic food will still hurt you, though."
	value = 0
	category = CATEGORY_FOOD
	gain_text = "<span class='notice'>You feel like you can eat any food type.</span>"
	lose_text = "<span class='notice'>You start to dislike certain food types again.</span>"
	medical_record_text = "Patient reports no strong dietary dislikes."

/datum/quirk/universal_diet/add()
	var/mob/living/carbon/human/H = quirk_holder
	var/datum/species/species = H.dna.species
	species.disliked_food = null

/datum/quirk/universal_diet/remove()
	var/mob/living/carbon/human/H = quirk_holder
	if(H)
		var/datum/species/species = H.dna.species
		species.disliked_food = initial(species.disliked_food)
