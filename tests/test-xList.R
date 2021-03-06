
kiwi ::: load_test_dependencies(environment())

message("xList")

	over(coll) +

	describe("xList can construct empty lists") +
	holdsWhen(
		is_collection(coll),
		xList[] %is% list()
	) +

	describe('xList on one list is similar to as.list') +
	holdsWhen(
		is_collection(coll),
		xList[x, x <- coll] %is% as.list(unname(coll))
	) +

	describe('predicates work with one binding') +
	holdsWhen(
		is_collection(coll),
		xList[x, x <- coll, True]  %is% as.list(unname(coll))
	) +

	run()

message('xList')

	over(coll) +

	describe('must have at least one binding') +
	failsWhen(
		is_collection(coll),
		xList[x],
		xList[x, y],
		xList[True]
	) +

	describe('must not being with binding expression') +
	failsWhen(
		is_collection(coll),
		xList[x <- coll, x],
		xList[x <- coll, y <- coll, x, y]
	) +

	run()
