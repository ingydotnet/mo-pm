ALL = ../lib/Mo.pm \
      ../lib/Mo/*.pm \

all: $(ALL)

$(ALL) : Makefile compress.pl

../lib/%.pm : %.pm
	perl compress.pl $< > $@
