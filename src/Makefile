ALL := \
    ../lib/Mo.pm \
    ../lib/Mo/autobuild.pm \
    ../lib/Mo/builder.pm \
    ../lib/Mo/build.pm \
    ../lib/Mo/coerce.pm \
    ../lib/Mo/default.pm \
    ../lib/Mo/has.pm \
    ../lib/Mo/is.pm \
    ../lib/Mo/required.pm \

all: $(ALL)

$(ALL) : Makefile compress.pl

../lib/%.pm : %.pm
	perl compress.pl $< > $@
