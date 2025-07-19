# XLXD Evolution
The XLX Multiprotocol Gateway Reflector Server is part of the software system
for multiple amateur radio digital modes. The sources are published under
GPL Licenses. The "Evolution" version of xlxd is a is a fork of xlxd that
intends to strongly track to upstream (if there are future changes)
but standardize and modernize the code. Specifically, the initial goals
are to:

* Reorganize the project so applications/files follow standard
Linux filesystem conventions
* Package for Debian
* Update the web GUI to create a responsive site for mobile
* Apply certain updates to further customization and branding of the GUI
* Include useful un-actioned pull requests from upstream

## Supported Protocols since XLX v2.5.x

- In D-Star, Icom-G3Terminal, DExtra, DPLus and DCS
- In DMR, DMRPlus (dongle) and DMRMmdvm
- In C4FM, YSF, Wires-X and IMRS
- XLX Interlink protocol

## Copyright

© 2016-2024 Jean-Luc Deltombe LX3JL and Luc Engelmann LX1IQ
© 2016-2025 Jason McCormick N8EI

# Usage

The packages which are described in this document are designed to install server
software which is used for the D-Star network infrastructure.
It requires a 24/7 internet connection which can support 20 voice streams or more
to connect repeaters and hotspot dongles!!

- The server requires a fix IP-address !
- The public IP address should have a DNS record which must be published in the
common host files.

If you want to run this software please make sure that you can provide this
service free of charge, like the developer team provides the software and the
network infrastructure free of charge!

# Requirements

The software packages for Linux are tested on Debian 12 and Debian 13.
The platforms x86\_64 and aarch64.

# Installation - Debian Packages
TODO

# Installation - Source Build
All installation is done as root - either `sudo -s` or prefix installation
steps with `sudo`.

* Install All dependendcies for buildling
    ```bash
    apt install build-essential g++ cmake wget git
    ```

* Build the software
    ```bash
    git clone https://github.com/jxmx/xlxd-evo.git
    cd xlxd-evo
    make
    ```

* Install Software
    ```bash
    make install
    make -f systemd/Makefile install-user
    ```

* Edit configuration
    ```bash
    nano /etc/default/xlxd
    nano /etc/default/ambed
    ```

    For the most basic/standard setup, just set the variable
    `REFLECTOR` to your reflector. For a new reflector, you
    need to pick a new ID from one not already used at 
    http://xlxapi.rlx.lu/index.php?show=reflectors

* Enable the services (ambed is optional for transcoding0
    ```bash
    systemctl daemon-reload
    systemctl start xlxd
    systemctl enable xlxd

    systemctl start ambed
    systemctl enable ambed
    ```

# Firewall Ports Needed

XLX Server requires some or all of the following ports to be open
and/or forwarded properly for network traffic:

 - UDP port 8880          (DMR+ DMO mode)
 - UDP port 10001         (json interface XLX Core)
 - UDP port 10002         (XLX interlink)
 - UDP port 10100         (AMBE controller port)
 - UDP port 10101 - 10199 (AMBE transcoding port)
 - UDP port 12345 - 12346 (Icom Terminal presence and request port)
 - UDP port 20001         (DPlus protocol)
 - UDP port 21110         (Yaesu IMRS protocol)
 - UDP port 30001         (DExtra protocol)
 - UDP port 30051         (DCS protocol)
 - UDP port 40000         (Icom Terminal dv port)
 - UDP port 42000         (YSF protocol)
 - UDP port 62030         (MMDVM protocol)

Additionally, if setting up the dashboard TCP/80 and TCP/443 
will be needed for HTTP and HTTPS traffic respectively.
