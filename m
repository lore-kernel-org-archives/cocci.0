From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 16 Mar 2017 09:44:02 +0100 (CET)
Subject: [Cocci] coccicheck run error
In-Reply-To: <20170316075052.GB27761@eros>
References: <20170315103555.GA27181@eros>
 <alpine.DEB.2.20.1703151200540.6227@hadrien> <20170315221054.GA13587@eros>
 <20170315221442.GA13992@eros> <alpine.DEB.2.20.1703160651580.3215@hadrien>
 <20170316075052.GB27761@eros>
Message-ID: <alpine.DEB.2.20.1703160942410.3631@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 16 Mar 2017, Tobin C. Harding wrote:

> On Thu, Mar 16, 2017 at 06:52:20AM +0100, Julia Lawall wrote:
> >
> >
> > On Thu, 16 Mar 2017, Tobin C. Harding wrote:
> >
> > > On Thu, Mar 16, 2017 at 09:10:54AM +1100, Tobin C. Harding wrote:
> > > > On Wed, Mar 15, 2017 at 12:01:24PM +0100, Julia Lawall wrote:
> > > > >
> > > > >
> > > > > On Wed, 15 Mar 2017, Tobin C. Harding wrote:
> > > > >
> > > > > > I am running coccinelle using
> > > > > >
> > > > > > $ make coccicheck MODE=report DEBUG_FILE=cocci-err.log M=drivers/staging/ks7010
> > > > > > Please check for false positives in the output before submitting a patch.
> > > > > > When using "patch" mode, carefully review the patch before submitting it.
> > > > > >
> > > > > > coccicheck failed
> > > > > >
> > > > > > $ cat cocci-err.log
> > > > > > 3 files match
> > > > > > Fatal error: exception Sys_error("alloc_cast: No such file or directory")
> > > > > >
> > > > > > Using V=1 gives no additional indication of the error.
> > > > > >
> > > > > > Any suggestions on how to proceed please?
> > > > >
> > > > > What version of Coccinelle do you have?  If you are not using the github
> > > > > version, perhaps you could try with that.
> > > >
> > > > Am having trouble building from the github repository. I tried
> > > >
> > > > $ ./autogen
> > > > $ ./configure
> > > > $ make -j9 >/dev/null
> > > > File "pyml-current/pyml_compat.ml", line 11, characters 20-38:
> > > > Warning 3: deprecated: Lazy.lazy_from_fun
> > > > Use Lazy.from_fun instead.
> > > > File "unparse_c.ml", line 2367, characters 6-18:
> > > > Warning 3: deprecated: String.unsafe_set
> > > > make[3]: *** No rule to make target '/usr/lib/ocaml/parmap/parmap.cmxa', needed by 'spatch.opt'.  Stop.
> > > > make[2]: *** [opt-compil] Error 2
> > > > make[1]: *** [all-release] Error 2
> > > > make: *** [all] Error 2
> > > >
> > > > I tried make all-dev also with the same result.
> > > >
> > > > thanks for you patience,
> > > > Tobin.
> > >
> > > Oh, and also FYI
> > > $sudo apt-get install ocaml ocaml-findlib libpcre-ocaml-dev pkg-config libpcre-ocaml-dev
> > > Reading package lists... Done
> > > Building dependency tree
> > > Reading state information... Done
> > > pkg-config is already the newest version (0.29.1-0ubuntu1).
> > > libpcre-ocaml-dev is already the newest version (7.0.4-2build1).
> > > ocaml is already the newest version (4.02.3-5ubuntu2).
> > > ocaml-findlib is already the newest version (1.5.5-2build1).
> >
> > Sorry for the problems.  Could you try make distclean?
>
> No problem what so ever. I'm certain that coccinelle is going to
> save me much more time spent editing source code by hand than whatever
> it takes to build :)
>
> I tried configuring without parmap but the make error is the same.
>
> $ ./configure --enable-parmap no
> $ make
> make[5]: Leaving directory '/home/tobin/build/github.com/coccinelle/coccinelle/tools/spgen'
> make[4]: Leaving directory '/home/tobin/build/github.com/coccinelle/coccinelle'
> make[3]: Leaving directory '/home/tobin/build/github.com/coccinelle/coccinelle'
> make spatch.opt BUILD_OPT=yes
> make[3]: Entering directory '/home/tobin/build/github.com/coccinelle/coccinelle'
> make[3]: *** No rule to make target '/usr/lib/ocaml/parmap/parmap.cmxa', needed by 'spatch.opt'.  Stop.
> make[3]: Leaving directory '/home/tobin/build/github.com/coccinelle/coccinelle'
> Makefile:164: recipe for target 'opt-compil' failed
> make[2]: *** [opt-compil] Error 2
> make[2]: Leaving directory '/home/tobin/build/github.com/coccinelle/coccinelle'
> Makefile:144: recipe for target 'all-release' failed
> make[1]: *** [all-release] Error 2
> make[1]: Leaving directory '/home/tobin/build/github.com/coccinelle/coccinelle'
> Makefile:122: recipe for target 'all' failed
> make: *** [all] Error 2
>
> I did `make distclean` as instructed. And re-did it all again with
> default configuration.
>
> I'm more than happy to keep trying things if you have the patience to
> direct me.

Obviously we should support installation without parmap, but if you want
to proceed before we can get back to you with a solution, perhaps just
install parmap.  https://github.com/rdicosmo/parmap

julia
