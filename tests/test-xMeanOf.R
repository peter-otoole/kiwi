
kiwi ::: load_test_dependencies(environment())

message("xMeanOf")

	over(nums) +

	describe('the mean of empty vector is double(0)') +
	holdsWhen(
		is_collection(nums) && length(nums) == 0,
		xMeanOf(nums) %is% double(0)
	) +

	describe('the mean of one number is itself') +
	holdsWhen(
		is_numeric(nums) && length(nums) == 1 &&
		!any(is.na(nums) || is.nan(nums)),
		xMeanOf(nums) == unname(nums)
	) +

	run()

	over(nums) +

	describe('fails for na or nan values') +
	failsWhen(
		is_numeric(nums) && any(is.na(nums) || is.nan(nums)),
		xMeanOf(nums)
	) +

	run()
