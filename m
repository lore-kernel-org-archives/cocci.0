From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 13 Jan 2016 15:15:33 +0100 (CET)
Subject: [Cocci] Build failure on ppc64le: Failure("dump: impossible tag
 (1002)")
In-Reply-To: <20160113134818.GA30557@redhat.com>
References: <20160113134818.GA30557@redhat.com>
Message-ID: <alpine.DEB.2.10.1601131514250.5214@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 13 Jan 2016, Richard W.M. Jones wrote:

>
> https://bugzilla.redhat.com/show_bug.cgi?id=1297855
> Build log:
> http://ppc.koji.fedoraproject.org/kojifiles/work/tasks/345/3060345/build.log
>
> In brief the build fails at:
>
> + /builddir/build/BUILDROOT/coccinelle-1.0.4-2.fc24.ppc64le/usr/bin/spatch -sp_file demos/simple.cocci demos/simple.c
> init_defs_builtins: /builddir/build/BUILDROOT/coccinelle-1.0.4-2.fc24.ppc64le/usr/lib64/coccinelle/standard.h
> Fatal error: exception Failure("dump: impossible tag (1002)")
>
> When thinking about this bug, don't exclude the possibility that there
> could be a problem in the OCaml compiler.  In Fedora we currently use
> a non-upstream ppc64le code generator, although we are planning to
> replace it soon(-ish) with the new upstream POWER code generator that
> Xavier wrote last year.

I would suspect that there is some structure type that has been added to
OCaml that we don't take into account.  I'll try to find out more
information.

julia
