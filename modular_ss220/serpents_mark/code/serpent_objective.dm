/datum/serpent_objective
	/// Objective's target and the fact that its a serpent's mark's objective
	var/name = "Serpent's Mark objective name placeholder"
	/// Extra info from client
	var/desc = "Serpent's Mark objective description placeholder"

	/// The mind who ordered the objective
	var/datum/mind/client
	/// The mind who took the objective
	var/datum/mind/executor
	/// Amount of ?credits? to be paid
	var/payment = 0
	/// When the executor marks the objective as completed
	var/marked_complete = FALSE
	/// When the client agrees
	var/actually_completed = FALSE
