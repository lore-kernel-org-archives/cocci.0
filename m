From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Wed, 14 Oct 2015 23:39:34 +0200
Subject: [Cocci] Common.union_setError (was: Compiling latest coccinelle
 with opensuse)
In-Reply-To: <alpine.DEB.2.02.1510142324400.1977@localhost6.localdomain6>
References: <alpine.DEB.2.02.1510132317080.2189@localhost6.localdomain6>
 <20151013220512.GE14464@wotan.suse.de>
 <alpine.DEB.2.02.1510140724160.2038@localhost6.localdomain6>
 <20151014071143.GA6178@pema>
 <alpine.DEB.2.10.1510140956240.2421@hadrien>
 <20151014085350.GB1543@pl-59055.rocqadm.inria.fr>
 <20151014205913.GH14464@wotan.suse.de>
 <alpine.DEB.2.02.1510142301540.1977@localhost6.localdomain6>
 <20151014212301.GJ14464@wotan.suse.de>
 <alpine.DEB.2.02.1510142324400.1977@localhost6.localdomain6>
Message-ID: <20151014213934.GL14464@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Oct 14, 2015 at 11:32:59PM +0200, Julia Lawall wrote:
> On Wed, 14 Oct 2015, Luis R. Rodriguez wrote:
> > The problem here stems from users of the internal inria git tree prior
> > to a release, nothing more.
> 
> I don't think so.  The only different between the Inria version and the 
> github version is whether parser_cocci_menhir.ml has to be created or is 
> provided.  But you created it with no problem (to my understanding).  The 
> problem came when you tried to compile it.  Then it refers to menhirLib.

But as I reported in my previous long detailed reply menhir is required
to be built if using the inria git, otherwise the build barfs with the error
I mentioned. So perhaps it was not desirable for that to be a requirement
but it seems it is -- at least for the non-github version?

> > For those users like myself the issue is
> > real, and I am now aware of it, and so should others. Since we know we
> > want to later strive towards one tree for development we should consider
> > this a bit more seriously though. Perhaps once compromise might be to
> > carry the pre-built files (as in github now) and *only* if a specific
> > non-default 'make menhir-update' type of target is used would we force
> > a re-generation of the files? Distributions should not need to run
> > this, ony admins of the git tree.
> > 
> > > Now that it has compiled, do you still have the problem with the 
> > > Common.union_set reference?
> > 
> > Oh yes. And the instructions I gave can be used to reproduce that
> > build I think as well now. To reproduce one can build coccinelle
> > on opensuse (I guess inria git version), and then apply this draft
> > patch onto linux-next (git am the file).
> 
> Just for another data point, could you try demos/iteration.cocci?  Or for 
> an even simpler test, demos/ocaml2.cocci.  No need to check the results.  
> I just want to know if they crash.

Also fails:

mcgrof at ergon ~/linux-next (git::20150805-pend-all)$ spatch -no_show_diff --sp-file iteration.cocci --dir ./
init_defs_builtins: /home/mcgrof/devel/coccinelle/standard.h
Using native version of ocamlc/ocamlopt/ocamldep
ocamlopt.opt -shared -o /tmp/ocaml_cocci_97ece2.cmxs -g -I /usr/lib64/ocaml  -I /home/mcgrof/devel/coccinelle//ocaml /tmp/ocaml_cocci_97ece2.ml
File "/tmp/ocaml_cocci_97ece2.ml", line 20, characters 23-39:
Error: Unbound value Common.union_set
Fatal error: exception Yes_prepare_ocamlcocci.CompileFailure("/tmp/ocaml_cocci_97ece2.ml")

  Luis
