
kiwi ::: load_test_dependencies(environment())

message("xAnyOf")

	over(coll) +

	describe('xAnyOf with identity is !any.') +
	holdsWhen(
		is.logical(coll) && length(coll) > 0,
		xAnyOf(identity, coll) %is% (length(which(coll)) > 0)
	) +

	describe('partially applying with true is false') +
	holdsWhen(
		is_collection(coll) && length(coll) > 0,
		xAnyOf(function (x) True, coll) == True
	) +

	describe('partially applying with false is true') +
	holdsWhen(
		is_collection(coll) && length(coll) > 0,
		xAnyOf(function (x) False, coll) == False,
		xAnyOf(function (x) Na,    coll) == False
	) +

	run()
