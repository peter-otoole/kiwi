
kiwi ::: load_test_dependencies(environment())

message("xNotEmpty")

	over(coll) +

	describe('xNotEmpty correctly reports lengths.') +
	holdsWhen(
		is_collection(coll),
		if (length(coll) == 0) !xNotEmpty(coll) else xNotEmpty(coll)
	) +

	run()
