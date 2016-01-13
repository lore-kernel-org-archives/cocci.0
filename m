From: rjones@redhat.com (Richard W.M. Jones)
Date: Wed, 13 Jan 2016 14:23:04 +0000
Subject: [Cocci] Build failure on ppc64le: Failure("dump: impossible tag
 (1002)")
In-Reply-To: <alpine.DEB.2.10.1601131516180.5214@hadrien>
References: <20160113134818.GA30557@redhat.com>
 <alpine.DEB.2.10.1601131516180.5214@hadrien>
Message-ID: <20160113142304.GL1766@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Jan 13, 2016 at 03:17:36PM +0100, Julia Lawall wrote:
> 
> 
> On Wed, 13 Jan 2016, Richard W.M. Jones wrote:
> 
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=1297855
> > Build log:
> > http://ppc.koji.fedoraproject.org/kojifiles/work/tasks/345/3060345/build.log
> >
> > In brief the build fails at:
> >
> > + /builddir/build/BUILDROOT/coccinelle-1.0.4-2.fc24.ppc64le/usr/bin/spatch -sp_file demos/simple.cocci demos/simple.c
> > init_defs_builtins: /builddir/build/BUILDROOT/coccinelle-1.0.4-2.fc24.ppc64le/usr/lib64/coccinelle/standard.h
> > Fatal error: exception Failure("dump: impossible tag (1002)")
> >
> > When thinking about this bug, don't exclude the possibility that there
> > could be a problem in the OCaml compiler.  In Fedora we currently use
> > a non-upstream ppc64le code generator, although we are planning to
> > replace it soon(-ish) with the new upstream POWER code generator that
> > Xavier wrote last year.
> 
> It is actually your code that is crashing :)
> 
> (* Dump an OCaml value into a printable string.
>  * By Richard W.M. Jones (rich at annexia.org).
>  * dumper.ml 1.2 2005/02/06 12:38:21 rich Exp
>  *)
> 
> Maybe you could send the output of man Obj in your version of Ocaml?

Not sure I understand - we don't change the Obj man page at all.

The implementation of OCaml objects (as in the object header and so
on) should also be the same, AFAIK.  Certainly the ppc64le backend
doesn't make any changes inside the OCaml compiler core, eg. to the GC
or libraries.  It's a 64 bit LE platform, so AFAIK the memory
structures ought to be identical to x86-64.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org
