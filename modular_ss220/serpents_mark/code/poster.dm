/obj/structure/sign/poster/contraband
	var/serpents_mark_code_probability = 5

/obj/structure/sign/poster/contraband/Initialize(mapload)
	. = ..()
	if(!prob(serpents_mark_code_probability))
		return

	var/code = GLOB.serpents_network.get_access_code()
	desc += "В углу постера нацарапан логотип Метки Змеи и код [code]."

/obj/structure/sign/poster/contraband/syndicate_recruitment
	serpents_mark_code_probability = 100
