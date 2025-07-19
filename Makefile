SRCNAME = xlxd-evo
PKGNAME = xlxd-evo
RELVER = 2.5.3
DEBVER = 1
RELPLAT ?= deb$(shell lsb_release -rs 2> /dev/null)

sysconfdir ?= /etc/xlxd
prefix ?= /usr
docdir ?= $(prefix)/share/doc/xlxd-evo

BUILDABLES = \
	src \
	ambed

INSTALLABLES = \
	config \
	systemd

ROOT_FILES = LICENSE README.md 
ROOT_INSTALLABLES = $(patsubst %, $(DESTDIR)$(docdir)/%, $(ROOT_FILES))

default: 
	$(foreach dir, $(BUILDABLES), \
		( mkdir -p $(dir)/build && cd $(dir)/build && cmake -DCMAKE_INSTALL_PREFIX=$(prefix) .. && make ) ; )

install: $(ROOT_INSTALLABLES) 
	$(foreach dir, $(BUILDABLES), ( cd $(dir)/build && make install); )
	$(foreach dir, $(INSTALLABLES), ( cd $(dir) && make install); )

setup:
	( cd systemd && make install-user; )

clean:
	$(foreach dir, $(BUILDABLES), ( cd $(dir)/build && make clean); )

distclean:
	$(foreach dir, $(BUILDABLES), rm -rf $(dir)/build; )

$(DESTDIR)$(docdir)/%: %
	install -D -m 0644  $< $@


deb:    debclean debprep
	debchange --distribution stable --package $(PKGNAME) \
	    --newversion $(EPOCHVER)$(RELVER)-$(DEBVER).$(RELPLAT) \
	    "Autobuild of $(EPOCHVER)$(RELVER)-$(DEBVER) for $(RELPLAT)"
	dpkg-buildpackage -b --no-sign
#	git checkout debian/changelog 

docker-deb: debclean debprep
	debchange --distribution unstable --package $(PKGNAME) \
	    --newversion $(RELVER)-$(DEBVER).$(RELPLAT) \
	    "Autobuild of $(RELVER)-$(DEBVER) for $(RELPLAT)"
	dpkg-buildpackage $(DPKG_BUILTOPTS)

debchange:
	debchange -v $(RELVER)-$(DEBVER)
	debchange -r

debprep:    debclean
	-find . -type d -name __pycache__ -exec rm -rf {} \;
	(cd .. && \
	    rm -f $(PKGNAME)-$(RELVER) && \
	    rm -f $(PKGNAME)-$(RELVER).tar.gz && \
	    rm -f $(PKGNAME)_$(RELVER).orig.tar.gz && \
	    ln -s $(SRCNAME) $(PKGNAME)-$(RELVER) && \
	    tar --exclude=".git" -h -zvcf $(PKGNAME)-$(RELVER).tar.gz $(PKGNAME)-$(RELVER) && \
	    ln -s $(PKGNAME)-$(RELVER).tar.gz $(PKGNAME)_$(RELVER).orig.tar.gz )

debclean:
	rm -f ../$(PKGNAME)_$(RELVER)*
	rm -f ../$(PKGNAME)-$(RELVER)*
	rm -f ../$(PKGNAME)*_$(RELVER)*
	rm -f ../$(PKGNAME)*-$(RELVER)*
	rm -rf debian/$(PKGNAME)
	rm -rf debian/$(PKGNAME)-ambed
	rm -rf debian/tmp
	rm -f debian/files
	rm -rf debian/.debhelper/
	rm -f debian/debhelper-build-stamp
	rm -f debian/*.substvars
	rm -rf debian/$(SRCNAME)/ debian/.debhelper/
	rm -f debian/debhelper-build-stamp debian/files debian/$(SRCNAME).substvars
	rm -f debian/*.debhelper

