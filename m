From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 16 Nov 2016 11:45:07 +0100 (CET)
Subject: [Cocci] Help in interpreting results
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B41C106A1@IRSMSX102.ger.corp.intel.com>
References: <2236FBA76BA1254E88B949DDB74E612B41C009A9@IRSMSX102.ger.corp.intel.com>
 <alpine.DEB.2.10.1611151215240.3153@hadrien>
 <2236FBA76BA1254E88B949DDB74E612B41C00A21@IRSMSX102.ger.corp.intel.com>
 <alpine.DEB.2.10.1611151335540.3153@hadrien>
 <2236FBA76BA1254E88B949DDB74E612B41C0E608@IRSMSX102.ger.corp.intel.com>
 <alpine.DEB.2.10.1611161106200.3153@hadrien>
 <2236FBA76BA1254E88B949DDB74E612B41C106A1@IRSMSX102.ger.corp.intel.com>
Message-ID: <alpine.DEB.2.10.1611161141130.3153@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 16 Nov 2016, Reshetova, Elena wrote:

> > >You may want to run coccinelle/scripts/idutils_index.sh in your code base.
> > >Then if you use the argument --use-idutils it will select the relevant files up front from the index and be even more >efficient.  Skipping means that it essentialy did a grep and didn't find anything.  If the argument after --use-idutils does >not begin with -, it will think that it is the name of the index.  The easiest is to just put --use-idutils last.
> >
> > Thank you for the suggestion! I will try this out. However, I seem to have a different problem that the rule doesn't behave as I would think it should and enabling debug doesn't tell terribly much.
> >
> > My rule is now this:
> >
> > @r1 exists@
> > identifier a, x;
> > position p1, p2;
> > identifier fname1 =~ ".*$free.*$";
> > identifier fname2 =~ ".*$kfree_.*$";
>
> >I'm not very good at regular expressions, but I thought that $ meant end of string.  So can it work to have $ before free/kfree?  Also, without the first $, I'm not sure to understand the difference between fname1 and fname2.  It looks like >anything matched by fname2 would also be matched by fname1.
>
> Yes, you are right, my memory of regular expression failed here. However, what confused me also here is that I had an explicit kfree match alternative:
>
> (
>   kfree at p2(a);
> |
>   fname1 at p2(a | (a, ...));
> |
> fname2 at p2(a | (a, ...));
> )
>
> Which didn't result in findings when it was called using some intermediate function. For this piece of code:
>
>  >     if (atomic_long_dec_and_test(&chunk->refs))
> >         free_chunk(chunk);
>
> Where free_chunk  calls it turn kfree(chunk).
>
> I got it working now with just one unified identifier, but I would like to understand better how coccinelle works in the above case to not make same mistakes in future.

Coccinelle is intraprocedural.  If you want interprocedural information,
you have to use a feature known as iteration.  There is an example in
demos/iteration.cocci (or python_iteration.cocci if you prefer python to
ocaml), and it is presented in this talk:

Advanced SmPL: http://coccinelle.lip6.fr/papers/cocciwk4_talk2.pdf

If the regexp is good enough for you in the short term, you may want to
stick with that.

julia
