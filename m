From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Mon, 27 Jul 2015 21:26:27 +0200
Subject: [Cocci] [PATCH 1/2] autotools: unify the way to determine
 version information
In-Reply-To: <CAJLtBvOwKOJacCNuHcOFTBoJ30RkpO8RPe_S5M48sfo-oa7AVg@mail.gmail.com>
References: <1437511861-2205-1-git-send-email-mcgrof@do-not-panic.com>
 <1437511861-2205-2-git-send-email-mcgrof@do-not-panic.com>
 <CAJLtBvOvZqYf0NP4R-Amu_sc6Cz8=J7_gFsCuKCtM1dQ4yk5tQ@mail.gmail.com>
 <20150724171228.GM30479@wotan.suse.de>
 <CAJLtBvOwKOJacCNuHcOFTBoJ30RkpO8RPe_S5M48sfo-oa7AVg@mail.gmail.com>
Message-ID: <20150727192627.GT30479@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, Jul 26, 2015 at 09:55:46AM +0300, Nikolay Orlyuk wrote:
> 2015-07-24 20:12 GMT+03:00 Luis R. Rodriguez <mcgrof@suse.com>:
> 
> > On Thu, Jul 23, 2015 at 07:18:34AM +0300, Nikolay Orlyuk wrote: > Do we
> > still need VERSION=$(shell ./version.sh | tr -d '\n') ? I'm pretty
> > > sure that VERSION=$(shell ./version.sh) will be enough. Same for
> > > configure.ac.
> > > Moreover why script version.sh can't be simply?
> > >
> > > #!/bin/sh
> > > > tr -d '\n' < ./version
> > > >
> >
> > These are identical:
> >
> > VERSION=`cat ./version | tr -d '\n'`
> > VERSION=`tr -d '\n' < ./version`
> >
> > I'll give you calling cat can be avoided so lets go with that.
> > Either way we want to stash it into a variable so we can later
> > expand on it with something not in the version file which is
> > instead taken from the script we are adding.
> >
> 
> That script is equivalent to:
> 
> #!/bin/sh
> > tr -d '\n' < version
> > ./scripts/setlocalversion | tr -d '\n'
> >
> 
> Storing variables just to expand it isn't required. I'd agree if there
> would be something like "${VERSION}-dirty${LOCALVERSION}" or printf "%s.%s"
> "${VERSION}" "${LOCALVERSION}"
> Just collecting output to print it again as-is seems redundant for me.
> That's all I wanted to say regarding that script.

Its a small optimization you seek for, the tradefoff IMHO is readibility and
since this code does not run often I don't think the optimization of not using
a variable helps much, and would easily allow extensions and customizations
as you note.

> Note that expansion of variable as argument without double-quotes for
> printf "%s" will results in removing spaces. If that's normal behavior it
> can be achieved more explicitly with "tr -d ' \n'" (include space in set of
> deleted chars alongside with '\n')

Not sure if that printf behaviour is POSIX compliant, in fact I hate /bin/sh
complaince confusion for the ambiguity here and in other places. I'll go with
what you propose.

> > > Other option would be to introduce subst. variable in configure.ac and
> > use
> > > it in configurable Makefile. This approach might be more widespread.
> >
> > We don't use automake, I think its best to keep it that way. I'll
> > just remove the double tr -d calls on both configure.ac and the top
> > level Makefile.
> >
> 
> I do not refer to automake.
> But we definitely use AC_INIT in configure.ac (autoconf) and according to
> http://www.gnu.org/software/autoconf/manual/autoconf.html#Initializing-configure
> we already can write:
> 
> diff --git a/Makefile b/Makefile
> index 061dbc1..9e4a47f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -43,7 +43,6 @@ endif
>  -include /etc/Makefile.coccinelle  # local customizations, if any
> 
> 
> -VERSION=$(shell cat ./version | tr -d '\n')
>  CCVERSION=$(shell cat scripts/coccicheck/README | egrep -o
> '[[:digit:]]+\.[[:digit:]]+\.[[:digit:]]+' | head -n1)
>  PKGVERSION=$(shell dpkg-parsechangelog
> -ldebian/changelog.$(DISTRIB_CODENAME) 2> /dev/null \
>          | sed -n 's/^Version: \(.*\)/\1/p' )
> diff --git a/Makefile.config.in b/Makefile.config.in
> index 10189d2..13cf64f 100644
> --- a/Makefile.config.in
> +++ b/Makefile.config.in
> @@ -1,3 +1,5 @@
> +VERSION=@PACKAGE_VERSION@
> +
>  # * for each library $1, add another entry in the same manner
>  MAKELIBS=@MAKE_dynlink@ @MAKE_menhirLib@ @MAKE_pycaml@ @MAKE_pcre@ \
>    @MAKE_parmap@

Ah very nice, yes. OK I'll respin and try to use this. I also I think found a way
to not require removing a git tag for a release, I'll add that too. I'll also highlight
that my this respin I addressed not requiring PGP tags, instead these are optional.

 Luis
