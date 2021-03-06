#
#   EnergyMech, IRC Bot software
#   Copyright (c) 1997-2009 proton
#
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public License as published by
#   the Free Software Foundation; either version 2 of the License, or
#   (at your option) any later version.
#
#   This program is distributed in the hope that it will be useful,
#   but WITHOUT ANY WARRANTY; without even the implied warranty of
#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#   GNU General Public License for more details.
#
#   You should have received a copy of the GNU General Public License
#   along with this program; if not, write to the Free Software
#   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
#

MISCFILES =	COPYING CREDITS README README.TCL TODO VERSIONS VERSIONS-1 Makefile configure \
		checkmech sample.conf sample.py sample.tcl sample.userfile default.bigchars

HELPFILES =	help/8BALL help/ACCESS help/ALIAS help/AWAY help/BAN help/BANLIST help/BYE \
		help/CCHAN help/CHACCESS help/CHANBAN help/CHANNELS help/CHAT help/CLEARSHIT \
		help/CMD help/CORE help/CSERV help/CTCP help/CYCLE help/DEOP help/DIE \
		help/DNS help/DNSSERVER help/DO help/DOWN help/ECHO help/ESAY help/FORGET \
		help/GREET help/HELP help/IDLE help/INSULT help/INVITE help/JOIN help/KB \
		help/KICK help/KS help/LAST help/LEVELS help/LINK help/LOAD help/LUSERS help/ME \
		help/MODE help/MSG help/NAMES help/NEXTSERVER help/NICK help/NOTIFY help/ONTIME \
		help/OP help/PART help/PASSWD help/PROTECTION help/PYTHON help/PYTHONSCRIPT \
		help/QSHIT help/RESET help/RKS help/RSHIT help/RSPY help/RT help/SAVE help/SAY \
		help/SCREW help/SEEN help/SERVER help/SERVERGROUP help/SET help/SETAAWAY \
		help/SETAOP help/SETAUB help/SETAVOICE help/SETCC help/SETCHANBAN help/SETCKL \
		help/SETDCC help/SETENFM help/SETENFMODES help/SETENFPASS help/SETFL help/SETFPL \
		help/SETIKT help/SETKS help/SETMAL help/SETMBL help/SETMDL help/SETMKL \
		help/SETMODES help/SETMPL help/SETNCL help/SETPASS help/SETPROT help/SETPUB \
		help/SETRK help/SETSD help/SETSERVERGROUP help/SETSHIT help/SETSO help/SETSTATS \
		help/SETTOP help/SHIT help/SHITLIST help/SHOWIDLE help/SHUTDOWN help/SITEBAN \
		help/SITEKB help/SPY help/STATS help/TCL help/TCLSCRIPT help/TIME help/TOPIC \
		help/UNALIAS help/UNBAN help/UNVOICE help/UP help/UPTIME help/USAGE help/USER \
		help/USERHOST help/USERLIST help/VER help/VERIFY help/VOICE help/WALL help/WHO \
		help/WHOIS help/WHOM

RANDFILES =	messages/8ball.txt messages/away.txt messages/insult.txt \
		messages/kick.txt messages/nick.txt messages/pickup.txt \
		messages/say.txt messages/signoff.txt messages/version.txt

STUBFILES =	src/Makefile.in src/config.h.in src/ld/mech.ldscript

TESTFILES =	config/cc.c config/inet_addr.c config/ldtest.c \
		config/ptr_size.c config/socket.c config/tcl.c config/which \
		config/md5.h config/md5_internal.c config/pw.c \
		config/inet_aton.c config/unaligned.c config/python.c

TRIVFILES =	trivia/mkindex.c

SRCFILES =	src/alias.c src/auth.c src/bounce.c src/chanban.c src/channel.c \
		src/core.c src/ctcp.c src/debug.c src/dns.c src/dynamode.c \
		src/function.c src/gencmd.c src/greet.c src/help.c src/irc.c \
		src/kicksay.c src/main.c src/mega.c src/net.c src/net_chan.c \
		src/note.c src/notify.c src/ons.c src/parse.c src/perl.c \
		src/prot.c src/python.c src/redirect.c src/reset.c src/seen.c \
		src/shit.c src/socket.c src/spy.c src/stats.c src/tcl.c \
		src/telnet.c src/toybox.c src/trivia.c src/uptime.c src/user.c \
		src/vars.c src/web.c src/md5/md5.c src/md5/md5.h

HDRFILES =	src/defines.h src/global.h src/h.h src/settings.h src/structs.h src/text.h src/usage.h

CONFFILES =	src/Makefile src/config.h

DISTFILES =	$(MISCFILES) $(RANDFILES) $(SRCFILES) $(HELPFILES) \
		$(STUBFILES) $(HDRFILES) $(TRIVFILES) $(TESTFILES)

#
# simple make rules
#

mech:		$(SRCFILES) $(CONFFILES)
		$(MAKE) -C src energymech

energymech:	$(SRCFILES) $(CONFFILES)
		$(MAKE) -C src energymech

clean:		FORCE
		$(MAKE) -C src clean

install:	FORCE
		$(MAKE) -C src install

#
# packing things up for distribution
#

dist:		FORCE
		$(MAKE) dist2 DISTDIR=`sed 's/^.*VERSION.*"\(.*\)".*$$/emech-\1/p; d;' src/global.h`

dist2:		FORCE
		rm -rf /tmp/$(DISTDIR)
		mkdir /tmp/$(DISTDIR)
		tar cf - $(DISTFILES) | ( cd /tmp/$(DISTDIR) ; tar --preserve -xf - )
		cd /tmp ; tar cf - $(DISTDIR) | gzip -9 > $(DISTDIR).tar.gz
		rm -rf /tmp/$(DISTDIR)
		chmod 644 /tmp/$(DISTDIR).tar.gz

FORCE:
