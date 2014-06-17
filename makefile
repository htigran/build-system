
include src/mk/setup.mk

DIRS	= \
	src/url_parser \
	src/test_url_parser

all : 
	-for d in $(DIRS); do (cd $$d; $(MAKE)); done

clean :
	$(ECHO) cleaning up in .
	-for d in $(DIRS); do (cd $$d; $(MAKE) clean ); done

force_look :
	true
