
kiwi ::: load_test_dependencies(environment())

as_typed_vector <- kiwi ::: as_typed_vector
as_atom         <- kiwi ::: as_atom

# as_typed_vector and as_atomic are two of the most complex functions
# in Kiwi, so they are heavily tested.

message("as_typed_vector (atomic)")

	over(coll) +

	# --------------------- length-zero --------------------- #

	describe("typed length-zero conversion always works for normal-modes") +
	holdsWhen(
		is_atomic(coll) && length(coll) == 0 && !is_named(coll),

		as_typed_vector(coll, 'integer')    %is% integer(0),
		as_typed_vector(coll, 'double')     %is% double(0),
		as_typed_vector(coll, 'character')  %is% character(0),
		as_typed_vector(coll, 'logical')    %is% logical(0),
		as_typed_vector(coll, 'complex')    %is% complex(0),
		as_typed_vector(coll, 'raw')        %is% raw(0)
	) +

	describe("typed length-zero conversion always works for normal-modes (named)") +
	holdsWhen(
		is_atomic(coll) && length(coll) == 0 && is_named(coll),

		as_typed_vector(coll, 'integer')    %is% as_named(integer(0)),
		as_typed_vector(coll, 'double')     %is% as_named(double(0)),
		as_typed_vector(coll, 'character')  %is% as_named(character(0)),
		as_typed_vector(coll, 'logical')    %is% as_named(logical(0)),
		as_typed_vector(coll, 'complex')    %is% as_named(complex(0)),
		as_typed_vector(coll, 'raw')        %is% as_named(raw(0))
	) +

	describe("typed length-zero conversion always works for numeric to integer") +
	holdsWhen(
		is_atomic(coll) && length(coll) == 0 && !is_named(coll) && typeof(coll) == 'integer',

		as_typed_vector(coll, 'numeric') %is% integer(0)
	) +

	describe("typed length-zero conversion always works for numeric to double") +
	holdsWhen(
		is_atomic(coll) && length(coll) == 0 && !is_named(coll) && typeof(coll) == 'double',

		as_typed_vector(coll, 'numeric') %is% double(0)
	) +

	describe("typed length-zero conversion always works for numeric to integer (named)") +
	holdsWhen(
		is_atomic(coll) && length(coll) == 0 && is_named(coll) && typeof(coll) == 'integer',

		as_typed_vector(coll, 'numeric') %is% as_named(integer(0))
	) +

	describe("typed length-zero conversion always works for numeric to double (named)") +
	holdsWhen(
		is_atomic(coll) && length(coll) == 0 && is_named(coll) && typeof(coll) == 'double',

		as_typed_vector(coll, 'numeric') %is% as_named(double(0))
	) +

	# --------------------- length-one --------------------- #

	describe("na conversion preserves names for non-raw") +
	holdsWhen(
		is_atomic(coll) && length(coll) == 1
		&& all(is.na(coll) & !is.nan(coll)) && is_named(coll),

		names(as_typed_vector(coll, 'numeric'))   == names(coll),
		names(as_typed_vector(coll, 'integer'))   == names(coll),
		names(as_typed_vector(coll, 'double'))    == names(coll),
		names(as_typed_vector(coll, 'character')) == names(coll),
		names(as_typed_vector(coll, 'logical'))   == names(coll),
		names(as_typed_vector(coll, 'complex'))    == names(coll)
	) +

	describe("na conversion changes type for non-raw") +
	holdsWhen(
		is_atomic(coll) && length(coll) == 1 &&
		all(is.na(coll) & !is.nan(coll)),

		typeof(as_typed_vector(coll, 'integer'))   == 'integer',
		typeof(as_typed_vector(coll, 'double'))    == 'double',
		typeof(as_typed_vector(coll, 'character')) == 'character',
		typeof(as_typed_vector(coll, 'logical'))   == 'logical',
		typeof(as_typed_vector(coll, 'complex'))    == 'complex'
	) +

	describe('na conversion to numeric doesnt change integer') +
	holdsWhen(
		is_atomic(coll) && length(coll) == 1 && all(is.na(coll) & !is.nan(coll)) &&
		typeof(coll) == 'integer',

		typeof(as_typed_vector(coll, 'numeric')) == 'integer'
	) +

	describe('na conversion to numeric doesnt change double') +
	holdsWhen(
		is_atomic(coll) && length(coll) == 1 && all(is.na(coll) & !is.nan(coll)) &&
		typeof(coll) == 'double',

		typeof(as_typed_vector(coll, 'numeric')) == 'double'
	) +

	describe('na conversion to numeric changes other types') +
	holdsWhen(
		is_atomic(coll) && length(coll) == 1 && all(is.na(coll) & !is.nan(coll)) &&
		!any(typeof(coll) == c('integer', 'double')),

		typeof(as_typed_vector(coll, 'numeric')) == 'double'
	) +

	describe("na conversion fails for raw") +
	failsWhen(
		is_atomic(coll) && length(coll) == 1 && 	all(is.na(coll) & !is.nan(coll)),

		as_typed_vector(coll, 'raw')
	) +

	# --------------------- length-any --------------------- #

	describe("conversion to numeric works for integers") +
	holdsWhen(
		is_atomic(coll) && !is_named(coll) &&
		typeof(coll) == 'integer',

		as_typed_vector(coll, 'numeric') %is% coll
	) +

	describe("conversion to numeric works for doubles") +
	holdsWhen(
		is_atomic(coll) && !is_named(coll) &&
		typeof(coll) == 'double',

		as_typed_vector(coll, 'numeric') %is% coll
	) +

	describe("conversion to own type works for all types") +
	holdsWhen(
		is_atomic(coll),

		as_typed_vector(coll, typeof(coll)) %is% coll
	) +

	run()

message("as_typed_vector (generic)")








message("as_atom (atomic)")

	over(coll) +

	describe("atom length-zero conversion always works") +
	holdsWhen(
		is_collection(coll) && length(coll) == 0 && !is_named(coll),
		as_atom(coll, 'numeric')   %is% numeric(0),
		as_atom(coll, 'integer')   %is% integer(0),
		as_atom(coll, 'double')    %is% double(0),
		as_atom(coll, 'character') %is% character(0),
		as_atom(coll, 'logical')   %is% logical(0),
		as_atom(coll, 'complex')   %is% complex(0),
		as_atom(coll, 'raw')       %is% raw(0)
	) +

	describe("atom length-zero conversion always works (named)") +
	holdsWhen(
		is_collection(coll) && length(coll) == 0 && is_named(coll),
		as_atom(coll, 'numeric')   %is% as_named(numeric(0)),
		as_atom(coll, 'integer')   %is% as_named(integer(0)),
		as_atom(coll, 'double')    %is% as_named(double(0)),
		as_atom(coll, 'character') %is% as_named(character(0)),
		as_atom(coll, 'logical')   %is% as_named(logical(0)),
		as_atom(coll, 'complex')   %is% as_named(complex(0)),
		as_atom(coll, 'raw')       %is% as_named(raw(0))
	) +

	run()

message("as_atom (generic")

