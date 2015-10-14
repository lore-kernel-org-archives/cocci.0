From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Wed, 14 Oct 2015 23:23:01 +0200
Subject: [Cocci] Common.union_setError (was: Compiling latest coccinelle
 with opensuse)
In-Reply-To: <alpine.DEB.2.02.1510142301540.1977@localhost6.localdomain6>
References: <alpine.DEB.2.02.1510132256380.2189@localhost6.localdomain6>
 <20151013211451.GD14464@wotan.suse.de>
 <alpine.DEB.2.02.1510132317080.2189@localhost6.localdomain6>
 <20151013220512.GE14464@wotan.suse.de>
 <alpine.DEB.2.02.1510140724160.2038@localhost6.localdomain6>
 <20151014071143.GA6178@pema>
 <alpine.DEB.2.10.1510140956240.2421@hadrien>
 <20151014085350.GB1543@pl-59055.rocqadm.inria.fr>
 <20151014205913.GH14464@wotan.suse.de>
 <alpine.DEB.2.02.1510142301540.1977@localhost6.localdomain6>
Message-ID: <20151014212301.GJ14464@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Oct 14, 2015 at 11:04:47PM +0200, Julia Lawall wrote:
> On Wed, 14 Oct 2015, Luis R. Rodriguez wrote:
> > On Wed, Oct 14, 2015 at 10:53:50AM +0200, S?bastien Hinderer wrote:
> > > Hi,
> > > 
> > > Luis: here is what I am guessing.
> > > 
> > > At some point in the past you have installed OCaml and then compiled
> > > Menhir from sources with that version of OCaml. Meanwhile the OCaml
> > > related packages got updated but Menhir has not been recompiled with
> > > the updated version of OCaml, hence the inconsistency.
> > > 
> > > My suggestion would thus be to make sure you recompile Menhir with the
> > > currently installed version of OCaml.
> > 
> > S?bastien,
> > 
> > your guess was correct. I also tested using a new base OpenSUSE factory
> > install for both github and inria git repos for coccinelle and found
> > that:
> > 
> >   * github: works as expected
> >   * inria git: required menhir but fails with a compilation failure [0]
> > 
> > Then with only the latest and greatest on inira git:
> > 
> >   * menhir: compiled
> >   * coccinelle: compiles
> > 
> > Once I forced recompilation of menhir things worked well. The
> > reason things seem to work on debian is menhir is packaged and
> > updated regularly, and I suppose it might be updated as ocaml
> > gets updated as otherwise Debian would run into similar issues,
> > and if not I suspect they will once ocaml on Debian does get
> > upgraded :)
> > 
> > I wonder how we'll avoid these dependency issues creeping up moving
> > forward. This is pretty fragile, and if the git tree will represent
> > later the latest and greatest what should we do about mehir
> > dependencies?
> 
> I guess that it is normal that if you install something with your package 
> manager, and another thing without your package manager, then they will 
> get out of synch in strange ways.  It doesn't really seem like 
> Coccinelle's problem, specifically.

The problem here stems from users of the internal inria git tree prior
to a release, nothing more. For those users like myself the issue is
real, and I am now aware of it, and so should others. Since we know we
want to later strive towards one tree for development we should consider
this a bit more seriously though. Perhaps once compromise might be to
carry the pre-built files (as in github now) and *only* if a specific
non-default 'make menhir-update' type of target is used would we force
a re-generation of the files? Distributions should not need to run
this, ony admins of the git tree.

> Now that it has compiled, do you still have the problem with the 
> Common.union_set reference?

Oh yes. And the instructions I gave can be used to reproduce that
build I think as well now. To reproduce one can build coccinelle
on opensuse (I guess inria git version), and then apply this draft
patch onto linux-next (git am the file).

http://drvbp1.linux-foundation.org/~mcgrof/coccinelle/common-union-issue/fw-warn-init-probe-draft-v2.patch

Then try it as follows:

# Note: cancel after 20 seconds otherwise, this patch is still
# being worked on, the current iteration use will run for a long
# time, don't waste your machine cycles / overheat your box.
export COCCI=scripts/coccinelle/api/request_firmware.cocci
make coccicheck MODE=report

I get:

Please check for false positives in the output before submitting a patch.
When using "patch" mode, carefully review the patch before submitting it.

File "/tmp/ocaml_cocci_27c72e.ml", line 21, characters 23-39:
File "/tmp/ocaml_cocci_eb7247.ml", line 21, characters 23-39:
File "/tmp/ocaml_cocci_82ec3c.ml", line 21, characters 23-39:
File "/tmp/ocaml_cocci_7c147c.ml", line 21, characters 23-39:
Error: Unbound value Common.union_setError: Unbound value Common.union_setError: Unbound value Common.union_set


Error: Unbound value Common.union_set
Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_27c72e.ml")
Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_eb7247.ml")
Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_7c147c.ml")
Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_82ec3c.ml")

> Sebastien seemed to think that the ability to 
> do dynamic linking in ocaml depends on more things than I would have 
> expected.  But I odn't know the details.

Interesting, let me know if you have any leads on a possible fix. In the
meantime I'll be debugging the above iteration SmPL patch on Debian.

  Luis
