ALL = ../lib/Mo.pm \
      ../lib/Mo/builder.pm \
      ../lib/Mo/default.pm \
      ../lib/Mo/has.pm \

all: $(ALL)

../lib/%: % compress.pl *akefile
	perl compress.pl $< > $@
