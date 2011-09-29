ALL := $(shell perl -e "print join q{ },map qq{../lib/\$$_},q{Mo.pm},glob(q{Mo/*.pm})") 

all: $(ALL)

$(ALL) : Makefile compress.pl

../lib/%.pm : %.pm
	perl compress.pl $< > $@
