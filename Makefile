SRCNAME = xlxd-evo
PKGNAME = xlxd-evo
RELVER = 1.5.1
DEBVER = 1
RELPLAT ?= deb$(shell lsb_release -rs 2> /dev/null)

BUILDABLES = \
    src 

ROOT_FILES = LICENSE README.md 
ROOT_INSTALLABLES = $(patsubst %, $(DESTDIR)$(docdir)/%, $(CONF_FILES))

default:
	$(foreach dir, $(BUILDABLES), \
		( mkdir $(dir)/build && cd $(dir)/build && cmake .. && make && make install); )

clean:
	$(foreach dir, $(BUILDABLES), ( cd $(dir)/build && make clean); )

distclean:
	$(foreach dir, $(BUILDABLES), rm -rf $(dir)/build; )
	

ambed:
	$(MAKE) -C ambed 
