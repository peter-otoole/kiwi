
forall <- arrow:::forall
test_cases <- arrow:::test_cases

message('xImplode')

	forall(
		"collapsing with character() is the same as collapsing with ''",
		test_cases$str_words,
		{
			xImplode('', strs) %equals%
			xImplode(character(0), strs)
		}
	)

	forall(
		"collapsing character() and '' acts as identity ",
		test_cases$str_word_and_words,
		{
			xImplode(str, strs) %equals%
			xImplode(str, strs[length(strs) != 0])
		}
	)

message('arrow $ xImplode')

	forall(
		"collapsing with character() is the same as collapsing with ''",
		test_cases$str_words,
		x_(strs)$xImplode('')$x_() %equals%
		x_(strs)$xImplode(character(0))$x_()
	)

message('arrow $ xImplode...')

message('arrow $ x_Implode')

	forall(
		"collapsing with character() is the same as collapsing with ''",
		test_cases$str_words,
		x_(strs)$x_Implode('') %equals%
		x_(strs)$x_Implode(character(0))
	)