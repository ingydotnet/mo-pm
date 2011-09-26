ALL = ../lib/Mo.pm \
      ../lib/Mo/autobuild.pm \
      ../lib/Mo/builder.pm \
      ../lib/Mo/default.pm \
      ../lib/Mo/has.pm \

all: $(ALL)

$(ALL): Mo.pm compress.pl Makefile
	perl compress.pl $(subst,..\lib\, $@) > $@
