ALL := \
    ../lib/Mo.pm \
    ../lib/Mo/build.pm \
    ../lib/Mo/builder.pm \
    ../lib/Mo/coerce.pm \
    ../lib/Mo/default.pm \
    ../lib/Mo/has.pm \
    ../lib/Mo/is.pm \
    ../lib/Mo/required.pm \
    ../lib/Mo/xs.pm \

all: $(ALL)

$(ALL) : Makefile

../lib/%.pm : %.pm
	perl -I../lib -MMo::Golf=golf < $< > $@
