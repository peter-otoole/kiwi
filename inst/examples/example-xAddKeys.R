
# 1.
#
# A really basic and unlikely use.

x_(c(1, 2, 3)) $ x_AddKeys(c('a', 'b', 'c'))

# c(a = 1, b = 2, c = 3)

# 2.
#
# Add the keys 'country' and 'age' to each row of a csv.

csv <- "Chad,16.6,Congo,16.5,Yemen,16.4,Mali,16.2,Niger,15.2,Uganda,15.0"

age_by_country <-
	x_(csv) $ xExplode(',') $ xChunk(2) $
	xMap( xUnspread((key : value) := {
		list(key, as.numeric(value))
	}) ) $
	x_Map( xAddKeys(c('country', 'age')) )

#
# list(
#     list(country = 'Chad',   age = 16.6),
#     list(country = 'Congo',  age = 16.5),
#     list(country = 'Yemen',  age = 16.4),
#     list(country = 'Mali',   age = 16.2),
#     list(country = 'Niger',  age = 15.2),
#     list(country = 'Uganda', age = 15.0)
# )
#
