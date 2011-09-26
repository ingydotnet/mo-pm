ALL = ../lib/Mo.pm \
      ../lib/Mo/builder.pm \
      ../lib/Mo/default.pm \
      ../lib/Mo/has.pm \

all: $(ALL)

../lib/Mo.pm: Mo.pm compress.pl Makefile
	perl compress.pl $< > $@

../lib/Mo/builder.pm: Mo/builder.pm compress.pl Makefile
	perl compress.pl $< > $@

../lib/Mo/default.pm: Mo/default.pm compress.pl Makefile
	perl compress.pl $< > $@

../lib/Mo/has.pm: Mo/has.pm compress.pl Makefile
	perl compress.pl $< > $@
