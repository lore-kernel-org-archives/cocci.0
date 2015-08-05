From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Wed, 5 Aug 2015 23:13:41 +0200
Subject: [Cocci] autotools: unify the way to determine version
	information
In-Reply-To: <55BB7AD6.4000307@users.sourceforge.net>
References: <1437511861-2205-1-git-send-email-mcgrof@do-not-panic.com>
 <1437511861-2205-2-git-send-email-mcgrof@do-not-panic.com>
 <CAJLtBvOvZqYf0NP4R-Amu_sc6Cz8=J7_gFsCuKCtM1dQ4yk5tQ@mail.gmail.com>
 <20150723071244.GA1536@pl-59055.rocqadm.inria.fr>
 <20150724185302.GO30479@wotan.suse.de>
 <55BB7AD6.4000307@users.sourceforge.net>
Message-ID: <20150805211341.GH30479@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Jul 31, 2015 at 03:40:38PM +0200, SF Markus Elfring wrote:
> > Using AC_SUBST() is overkill and we don't use automake.
> 
> How do you think about the consequences from a call of the macro "AM_INIT_AUTOMAKE" then?
> https://github.com/coccinelle/coccinelle/blob/e7dd46783d6addd7efad735144d85ed8fde841ce/configure.ac#L13
> http://www.gnu.org/software/automake/manual/html_node/Requirements.html

Can't say I care.

> > I try to avoid using autotools at all costs so if you would like that
> > instead a replacement patch by you might be more suitable.
> 
> Do you fiddle also with other software build specifications occasionally?

I've only looked enough at autotools to pationately hate it.

Its year 2015 and the requirements for designing autotools
should now be superceded with simple mechanisms and modern
helpers.

  Luis
