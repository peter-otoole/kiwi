
kiwi ::: load_test_dependencies(environment())

message("xIterate")

	over(val) +

	describe("returning a val is val") +
	holdsWhen(
		True,
		xIterate(function (val) Return(val), val) %is% val
	) +

	run()
