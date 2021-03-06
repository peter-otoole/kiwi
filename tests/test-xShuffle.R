
kiwi ::: load_test_dependencies(environment())

message("xShuffle")

	over(coll) +

	describe("shuffling the empty collection returns the empty list") +
	holdsWhen(
		is_collection(coll) && length(coll) == 0 && !is_named(coll),

		xShuffle(coll) %is% list()
	) +

	describe("shuffling the empty collection returns the empty list (named)") +
	holdsWhen(
		is_collection(coll) && length(coll) == 0 && is_named(coll),

		xShuffle(coll) %is% as_named(list())
	) +

	describe("length is preserved") +
	holdsWhen(
		is_collection(coll),

		length(xShuffle(coll)) %is% length(coll)
	) +

	run()
