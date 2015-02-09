From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 9 Feb 2015 09:51:13 +0100 (CET)
Subject: [Cocci] Build errors with coccinelle 1.0.0-rc24 on OpenBSD and
 Linux
In-Reply-To: <20150209082115.GD1632@pl-59055.rocqadm.inria.fr>
References: <20150208214908.GM24492@acyclic.org>
 <20150209082115.GD1632@pl-59055.rocqadm.inria.fr>
Message-ID: <alpine.DEB.2.10.1502090949070.6846@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 9 Feb 2015, S?bastien Hinderer wrote:

> Dear Douglas,
>
> Thanks a lot for the report.
>
> Doug Hogan (2015/02/08 13:49 -0800):
> > There are two build errors with this release.  I think both are due to
> > assuming you have parmap installed rather than using the bundled
> > version.
>
> As far as I know, the way it is supposed to work is rather the
> opposite: the build system is supposed to unconditionnally use the
> bundled version. It is also supposed to ignore an installed version,
> which can of course be considered as not very optimal, but that's how
> the situation is supposed to be currently.

Not at all.  The build system is supposed to use the installed version if
one is available.

> > For OpenBSD, I'm running OpenBSD -current with OCaml 4.02.1 (ports).
> > For Linux, I'm running Debian testing with OCaml 4.01.0.
>
> I'm also using Debian testing, just re-downloaded the archive of
> 1.0-rc24 rom Coccinlle's web site, unpacked, ran ./configure and make,
> but onmy system it worked,so I'm unable o reproduce the problem so far.

Perhaps you have Parmap installed?

> > Parmap has a bug that prevents it from building on any OS that doesn't
> > have <mach/threads_policy.h> which includes OpenBSD and Linux.  Here's
> > the syntax fix:

Doug, this version has now been fixed on the Parmap side,  Thanks again
for the report.

julia
