SRCNAME = xlxd-evo
PKGNAME = xlxd-evo
RELVER = 1.5.1
DEBVER = 1
RELPLAT ?= deb$(shell lsb_release -rs 2> /dev/null)

sysconfdir ?= /etc/xlxd
prefix ?= /usr
docdir ?= $(prefix)/share/doc/xlxd-evo

BUILDABLES = \
    src \
	ambed

INSTALLABLES = \
	config

ROOT_FILES = LICENSE README.md 
ROOT_INSTALLABLES = $(patsubst %, $(DESTDIR)$(docdir)/%, $(ROOT_FILES))

default: 
	$(foreach dir, $(BUILDABLES), \
		( mkdir -p $(dir)/build && cd $(dir)/build && cmake -DCMAKE_INSTALL_PREFIX=$(prefix) .. && make ) ; )

install: $(ROOT_INSTALLABLES) 
	$(foreach dir, $(BUILDABLES), ( cd $(dir)/build && make install); )
	$(foreach dir, $(INSTALLABLES), ( cd $(dir) && make install); )


clean:
	$(foreach dir, $(BUILDABLES), ( cd $(dir)/build && make clean); )

distclean:
	$(foreach dir, $(BUILDABLES), rm -rf $(dir)/build; )

$(DESTDIR)$(docdir)/%: %
	install -D -m 0644  $< $@
