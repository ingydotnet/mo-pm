ALL = ../lib/Mo.pm \
      ../lib/Mo/builder.pm \
      ../lib/Mo/default.pm \
      ../lib/Mo/has.pm \

all: $(ALL)

$(ALL) : Makefile compress.pl
../lib/%.pm : %.pm
	perl compress.pl $< > $@
