
kiwi ::: load_test_dependencies(environment())

message("xKeysOf")

	over(coll) +

	describe("keys of always returns character") +
	holdsWhen(
		is_collection(coll),

		is.character(xKeysOf(coll))
	) +

	describe("keys of is character 0 for no names") +
	holdsWhen(
		is_collection(coll) && !is_named(coll),

		xKeysOf(coll) %is% character(0)
	) +

	describe("keys of is names") +
	holdsWhen(
		is_collection(coll) && is_named(coll),

		xKeysOf(coll) %is% names(coll)
	) +

	run()
