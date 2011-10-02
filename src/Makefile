ALL := \
    ../lib/Mo.pm \
    ../lib/Mo/builder.pm \
    ../lib/Mo/build.pm \
    ../lib/Mo/coerce.pm \
    ../lib/Mo/default.pm \
    ../lib/Mo/has.pm \
    ../lib/Mo/is.pm \
    ../lib/Mo/required.pm \
    ../lib/Mo/xxx.pm \

all: $(ALL)

$(ALL) : Makefile

../lib/%.pm : %.pm
	perl -I../lib -MMo::Golfer -e "Mo::Golfer::run" $< > $@
