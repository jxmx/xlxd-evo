XLXD_SYSTEMD_FILES = \
	$(DESTDIR)/lib/systemd/system/xlxd.service \
	$(DESTDIR)/etc/default/xlxd

AMBED_SYSTEMD_FILES= \
	$(DESTDIR)/lib/systemd/system/ambed.service

install:	$(XLXD_SYSTEMD_FILES)

install-user:	ensure-xlxd-user

install-ambed:	$(AMBED_SYSTEMD_FILES)

$(DESTDIR)/lib/systemd/system/%: %
	install -D -m 0644  $< $@
	systemctl daemon-reload

$(DESTDIR)/etc/default/%: %.default
	install -D -m 0644  $< $@

.PHONY:	ensure-xlxd-user
ensure-xlxd-user:
	@if [ "$$(id -u)" -ne 0 ]; then \
		echo "Must run as root"; \
		exit 1; \
	fi
	@if ! id xlxd > /dev/null 2>&1; then \
		useradd -r -s /usr/sbin/nologin -d /etc/xlxd xlxd; \
	fi \
