From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 30 Jul 2015 15:50:37 +0200 (CEST)
Subject: [Cocci] [PATCH v3 2/2] autotools: add localversion information
In-Reply-To: <1438034612-10595-3-git-send-email-mcgrof@do-not-panic.com>
References: <1438034612-10595-1-git-send-email-mcgrof@do-not-panic.com>
 <1438034612-10595-3-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <alpine.DEB.2.10.1507301547480.2439@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Say you have a linear set of history and you are about to make a 1.0.2
> release, you'd can do tthis:
>
> a) Edit the version file and bump it to 1.0.2
> b) Run: git clean -f -x -d
> d) Run: ./autogen --ignore_localversion
> e) git commit -a -s
> g) Run: git tag 1.0.2

The actual version release process seems to be this (extracted from
Makefile.release):

        @echo "\n\tEdit ./version"
        @echo "\n\tRun ./autogen"

        $(GIT) add ./version
        $(GIT) add ./configure
        $(GIT) add setup/Makefile.in
        $(GIT) commit -m "Release $(VERSION)"
        $(GIT) tag -a -m "Release $(VERSION)" $(VERSION)
        $(GIT) push origin $(VERSION)

(except that the push doesn't seem to happen...).  So the idea would be
just to modify the second "echo" line to add the argument
--ignore_localversion?

julia

> When working from source, the average user and developer will run just
> ./autogen, this will peg the local version into the version string.
> Likewise if no git tree exists they'll get the default version string.
>
> Cc: Peter Senna Tschudin <peter.senna@gmail.com>
> Cc: Nikolay Orlyuk <virkony@gmail.com>
> Cc: S?bastien Hinderer <Sebastien.Hinderer@inria.fr>
> Cc: Quentin Lambert <lambert.quentin@gmail.com>
> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> ---
>  autogen                 |   5 +++
>  scripts/setlocalversion | 117 ++++++++++++++++++++++++++++++++++++++++++++++++
>  version.sh              |   3 ++
>  3 files changed, 125 insertions(+)
>  create mode 100755 scripts/setlocalversion
>
> diff --git a/autogen b/autogen
> index 424edade2d46..31c0630aa403 100755
> --- a/autogen
> +++ b/autogen
> @@ -1,3 +1,8 @@
>  #!/bin/sh
> +if [ "$1" = "--ignore_localversion" ]; then
> +	export MAKE_COCCI_RELEASE="y"
> +else
> +	unset MAKE_COCCI_RELEASE
> +fi
>  aclocal -I setup
>  autoconf
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> new file mode 100755
> index 000000000000..728b54e9ee9f
> --- /dev/null
> +++ b/scripts/setlocalversion
> @@ -0,0 +1,117 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2005-2006 Ryan Anderson <ryan@michonline.com>
> +# Copyright (c) 2006 Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
> +# Copyright (c) 2006 Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
> +# Copyright (c) 2007 Aron Griffis <aron@hp.com>
> +# Copyright (c) 2007 Theodore Ts'o <tytso@mit.edu>
> +# Copyright (c) 2008 Bryan Wu <bryan.wu@analog.com>
> +# Copyright (c) 2008 Mike Frysinger <vapier@gentoo.org>
> +# Copyright (c) 2008 Peter Korsgaard <jacmet@sunsite.dk>
> +# Copyright (c) 2008 Sebastian Siewior <lkml@ml.breakpoint.cc>
> +# Copyright (c) 2008 Trent Piepho <tpiepho@freescale.com>
> +# Copyright (c) 2009 Mike Frysinger <vapier.adi@gmail.com>
> +# Copyright (c) 2009 Nico Schottelius <nico-linuxsetlocalversion@schottelius.org>
> +# Copyright (c) 2009 Peter Korsgaard <jacmet@sunsite.dk>
> +# Copyright (c) 2010 Linus Torvalds <torvalds@linux-foundation.org>
> +# Copyright (c) 2010 Michael Prokop <mika@grml.org>
> +# Copyright (c) 2010 Micha? G?rny <gentoo@mgorny.alt.pl>
> +# Copyright (c) 2010 Michal Marek <mmarek@suse.cz>
> +# Copyright (c) 2010 Milton Miller <miltonm@bga.com>
> +# Copyright (c) 2011 Mike Crowe <mcrowe@zipitwireless.com>
> +# Copyright (c) 2012 Roland Dreier <roland@purestorage.com>
> +# Copyright (c) 2013 Christian Kujau <lists@nerdbynature.de>
> +# Copyright (c) 2013 Christophe Leroy <christophe.leroy@c-s.fr>
> +# Copyright (c) 2013 Franck Bui-Huu <fbuihuu@gmail.com>
> +# Copyright (c) 2015 Luis R. Rodriguez <mcgrof@do-not-panic.com>
> +#
> +# This file is released under the GPLv2.
> +#
> +# Taken from the Linux kernel as of v4.2-rc2 with a few modifications
> +# described below.
> +#
> +# This scripts adds local version information from the version
> +# control systems. It was taken from the Linux kernel as of v4.2-rc2
> +# and simplified for use on Coccinelle by mcgrof. The version info
> +# was hard coded to use long version. The svn postfix details were
> +# also removed. I also added the option to enable this script to
> +# work well for trees that do not use PGP signed tags or annotated
> +# tags (git tag -s or git tag -a), git describe by default will only
> +# look for these tags. If you do not use these you will want to set
> +# the below variable to TAGS="--tags". If  you requires --tags, consider
> +# to start signing your releases "git tag -s" and use a subkey for that.
> +# If you do that, consider also using another PGP subkey for annotating
> +# releases as deprecated.
> +#
> +# Set to emtpy variable if you use properly signed tags. You should do this!
> +TAGS="--tags"
> +
> +srctree=.
> +
> +scm_version()
> +{
> +	local short
> +	short=false
> +
> +
> +	# Check for git and a git repo.
> +	if test -z "$(git rev-parse --show-cdup 2>/dev/null)" &&
> +	   head=`git rev-parse --verify --short HEAD 2>/dev/null`; then
> +
> +		# If we are at a tagged commit (like "v2.6.30-rc6"), we ignore
> +		# it, because this version is defined in the top level Makefile.
> +		if [ -z "`git describe $TAGS --exact-match 2>/dev/null`" ]; then
> +
> +			# If only the short version is requested, don't bother
> +			# running further git commands
> +			if $short; then
> +				echo "+"
> +				return
> +			fi
> +			# If we are past a tagged commit (like
> +			# "v2.6.30-rc5-302-g72357d5"), we pretty print it.
> +			if atag="`git describe $TAGS 2>/dev/null`"; then
> +				echo "$atag" | awk -F- '{printf("-%05d-%s", $(NF-1),$(NF))}'
> +
> +			# If we don't have a tag at all we print -g{commitish}.
> +			else
> +				printf '%s%s' -g $head
> +			fi
> +		fi
> +
> +		# Check for uncommitted changes
> +		if git diff-index --name-only HEAD | grep -qv "^scripts/package"; then
> +			printf '%s' -dirty
> +		fi
> +
> +		# All done with git
> +		return
> +	fi
> +
> +	# Check for mercurial and a mercurial repo.
> +	if test -d .hg && hgid=`hg id 2>/dev/null`; then
> +		# Do we have an tagged version?  If so, latesttagdistance == 1
> +		if [ "`hg log -r . --template '{latesttagdistance}'`" == "1" ]; then
> +			id=`hg log -r . --template '{latesttag}'`
> +			printf '%s%s' -hg "$id"
> +		else
> +			tag=`printf '%s' "$hgid" | cut -d' ' -f2`
> +			if [ -z "$tag" -o "$tag" = tip ]; then
> +				id=`printf '%s' "$hgid" | sed 's/[+ ].*//'`
> +				printf '%s%s' -hg "$id"
> +			fi
> +		fi
> +
> +		# Are there uncommitted changes?
> +		# These are represented by + after the changeset id.
> +		case "$hgid" in
> +			*+|*+\ *) printf '%s' -dirty ;;
> +		esac
> +
> +		# All done with mercurial
> +		return
> +	fi
> +}
> +
> +res="$res$(scm_version)"
> +echo "$res"
> diff --git a/version.sh b/version.sh
> index 02a5b7253ba9..2bf6587a5760 100755
> --- a/version.sh
> +++ b/version.sh
> @@ -1,2 +1,5 @@
>  #!/bin/sh
>  tr -d '\n' < ./version
> +if test "x$MAKE_COCCI_RELEASE" = "x"; then
> +	./scripts/setlocalversion | tr -d '\n'
> +fi
> --
> 2.3.2.209.gd67f9d5.dirty
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
