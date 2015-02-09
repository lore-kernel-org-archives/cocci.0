From: doug@acyclic.org (Doug Hogan)
Date: Mon, 9 Feb 2015 04:58:59 -0800
Subject: [Cocci] Build errors with coccinelle 1.0.0-rc24 on OpenBSD and
 Linux
In-Reply-To: <20150209082115.GD1632@pl-59055.rocqadm.inria.fr>
References: <20150208214908.GM24492@acyclic.org>
 <20150209082115.GD1632@pl-59055.rocqadm.inria.fr>
Message-ID: <20150209125859.GP24492@acyclic.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Feb 09, 2015 at 09:21:15AM +0100, S??bastien Hinderer wrote:
> I'm also using Debian testing, just re-downloaded the archive of
> 1.0-rc24 rom Coccinlle's web site, unpacked, ran ./configure and make,
> but onmy system it worked,so I'm unable o reproduce the problem so far.

You're correct.  setcore_stubs.c is probably only a problem on OSes other
than Linux and OS X.

On Linux, I'm able reproduce the error with a fresh download, but it
requires trying a build without ocamlfind.  Ocamlfind is not one of the
suggestions, recommendations or dependencies for the 'ocaml' package in
Debian.  I didn't install it until coccinelle complained during the
build.  I have tried all sorts of scenarios, but this is the one that
fails in Linux for me:

* Only install OCaml in Debian
   - You can install libparmap or libparmap-dev (doesn't help or hurt)
   - Do not install ocaml-findlib.  If you have it installed, remove it.
* Extract the coccinelle tarball and run ./configure
* Run 'make'
* Build fails in Parmap when it tries to run ocamlfind
* Install ocaml-findlib to resolve the missing 'ocamlfind' error
* Run 'make clean && ./configure && make' to restart the build
  (or so I thought)
* Build fails at the end with Error: Unbound module Parmap

If I run 'make clean && make' instead, I also see the
"Error: Unbound module Parmap".

If I run 'make distclean && ./configure && make', it will fail early
because it can't find a file.

If I re-extract the coccinelle tarball in a new directory and run
"./configure && make" there, it will build fine.  I presume that's
because I had ocamlfind from the start.

Is there any way to restart a build when configure doesn't pick up
ocamlfind?  Do you have to blow away the directory and re-extract it?
Based on what I found, my guess is that I tried reconfiguring it and
didn't try re-extracting the tarball enough times.  I associated
the libparmap package being installed with success but it was really
having ocamlfind + fresh build directory that worked.

Should the configure script fail when it doesn't find ocamlfind?  Or
is there something else going on here?  It doesn't appear that using
the fake-stub.sh script is sufficient.


I think the problem with OpenBSD is something different.  Our port
of OCaml includes ocamlfind so that can't be the issue.  It may be
something simple still.  I'll try reaching out to one of the OCaml port
maintainers in OpenBSD.
