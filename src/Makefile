ALL := \
    ../lib/Mo.pm \
    ../lib/Mo/build.pm \
    ../lib/Mo/builder.pm \
    ../lib/Mo/chain.pm \
    ../lib/Mo/coerce.pm \
    ../lib/Mo/default.pm \
    ../lib/Mo/exporter.pm \
    ../lib/Mo/has.pm \
    ../lib/Mo/import.pm \
    ../lib/Mo/importer.pm \
    ../lib/Mo/is.pm \
    ../lib/Mo/nonlazy.pm \
    ../lib/Mo/option.pm \
    ../lib/Mo/required.pm \
    ../lib/Mo/xs.pm \
    ../lib/Mo/Moose.pm \
    ../lib/Mo/Mouse.pm \

all: $(ALL)

$(ALL) : Makefile

../lib/%.pm : %.pm
	perl -I../lib -MMo::Golf=golf < $< > $@

.PHONY: version

version:
	perl update_version.pl
