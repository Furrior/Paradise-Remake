GLOBAL_DATUM_INIT(serpents_network, /datum/serpents_network, new)

/datum/serpents_network
	/// All objectives created during current round
	var/list/datum/serpent_objective/all_objectives
	/// Objectives available to be taken by executors
	var/list/datum/serpent_objective/available_objectives
	/// Taken but not completed objectives
	var/list/datum/serpent_objective/active_objectives

/// Returns a greek letter + random number code
/datum/serpents_network/proc/generate_access_code()
	PROTECTED_PROC(TRUE)
	var/list/greek_alphabet = list(
    "Alpha", "Beta", "Gamma", "Delta", "Epsilon", "Zeta", "Eta", "Theta", "Iota",
    "Kappa", "Lambda", "Mu", "Nu", "Xi", "Omicron", "Pi", "Rho", "Sigma", "Tau",
    "Upsilon", "Phi", "Chi", "Psi", "Omega"
	)
	// Letter + random number to dont have collisions with uplink codes that use random number + letter
	return "[pick(greek_alphabet)] [rand(100,999)]"

/// Generates the code at the world start and returns it
/datum/serpents_network/proc/get_access_code()
	var/static/code
	if(!code)
		code = generate_access_code()
	return code

/// Checks if the access code is correct and opens the UI if it is
/datum/serpents_network/proc/check_trigger(mob/user, input_code)
	if(input_code != get_access_code())
		return FALSE
	open_serpents_network_ui(user)
	return TRUE

/// Opens the TGUI
/datum/serpents_network/proc/open_serpents_network_ui(mob/user)
	ui_interact(user)

/datum/serpents_network/ui_interact(mob/user, datum/tgui/ui = null)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "SerpentsNetwork", "Serpent's Mark")
		ui.open()

/// Publishes a new objective to the network
/datum/serpents_network/proc/publish_objective(mob/user, datum/serpent_objective/objective_to_publish)
	// TODO: Take the payment for publishing


	all_objectives.Add(objective_to_publish)
	available_objectives.Add(objective_to_publish)

	// TODO: Probably annouce

/// Take an objective and bind it to the user
/datum/serpents_network/proc/take_objective(mob/user, datum/serpent_objective/objective_to_take)
	available_objectives.Remove(objective_to_take)
	active_objectives.Add(objective_to_take)

	ASSERT(user.mind)
	objective_to_take.executor = user.mind

	// TODO: List of taken objectives

/// Mark taken objective as completed
/datum/serpents_network/proc/mark_objective_complete(mob/user, datum/serpent_objective/objective_to_mark, proof_of_completion)
	objective_to_mark.marked_complete = TRUE

/// Complete an objective and pay the reward to the executor
/datum/serpents_network/proc/complete_objective(mob/user, datum/serpent_objective/objective_to_complete)
	// No checks in case client agrees on completition without proofs

	objective_to_complete.actually_completed = TRUE
	active_objectives.Remove(objective_to_complete)

	pay_reward(objective_to_complete)

/// Pay the reward to the executor
/datum/serpents_network/proc/pay_reward(datum/serpent_objective/completed_objective)
	var/payment = completed_objective.payment
	var/executor = completed_objective.executor

	if(!executor)
		return
	// TODO actual payment
