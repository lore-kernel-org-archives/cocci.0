From: joel@joelfernandes.org (Joel Fernandes)
Date: Wed, 10 Oct 2018 14:11:25 -0700
Subject: [Cocci] First coccinelle script, need some help.
In-Reply-To: <alpine.DEB.2.21.1810102249410.2479@hadrien>
References: <20181010193854.GA93016@joelaf.mtv.corp.google.com>
 <alpine.DEB.2.21.1810102217260.2479@hadrien>
 <20181010204517.GA109962@joelaf.mtv.corp.google.com>
 <alpine.DEB.2.21.1810102249410.2479@hadrien>
Message-ID: <20181010211125.GA128537@joelaf.mtv.corp.google.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, Oct 10, 2018 at 10:51:28PM +0200, Julia Lawall wrote:
> 
> 
> On Wed, 10 Oct 2018, Joel Fernandes wrote:
> 
> > On Wed, Oct 10, 2018 at 10:23:18PM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Wed, 10 Oct 2018, Joel Fernandes wrote:
> > >
> > > >
> > > > Hi!
> > > >
> > > > I am trying to determine if a function argument is used across the whole
> > > > kernel for a certain kernel function.
> > > >
> > > > I mustered up enough courage to write my first coccinelle script after a few
> > > > late nights of reading up about it :)
> > > >
> > > > Here is .cocci script. I am trying to find if address is used at all in any
> > > > possible definitions of pte_alloc():
> > > >
> > > > $ cat ~/pte_alloc.cocci
> > > > virtual report
> > > >
> > > > @pte_args depends on report@
> > > > identifier E1, E2;
> > > > type T1, T2;
> > > > position p;
> > > > @@
> > > >
> > > >  pte_alloc at p(T1 E1, T2 E2)
> > > >  {
> > > > ...
> > > > (
> > > > ...
> > > >  E2
> > > > ...
> > > > )
> > > > ...
> > > >  }
> > >
> > >
> > > In report mode, by default, the pattern has to match on all paths.  Also
> > > when you have ... before or after E2, there can be no occurrence of E2 in
> > > the code matched by the ...  So your rule requires that on every possible
> > > execution path through the function, there is exactly one occurrence of
> > > E2.
> > >
> > > You can try the following instead:
> > >
> > > virtual report
> > >
> > > @pte_args depends on report exists@
> > > identifier E1, E2;
> > > type T1, T2;
> > > position p;
> > > @@
> > >
> > >  pte_alloc at p(T1 E1, T2 E2)
> > >  {
> > >  ... when any
> > >  E2
> > >  ... when any
> > >  }
> >
> > Thanks for the quick reply.
> > If I just add 'depends on report exists' to the rule, then my original
> > example works fine now. I did not need to add the 'when any'. Do you mind
> > taking my original simple test.c example and modify it and let me know under
> > what situation would it not work?
> >
> > I even added address = 1 outside of the if block and it works fine, I see the
> > warning as I expect without 'when any' in pront of the "...".
> >
> > struct page *pte_alloc(struct mm_struct *mm, unsigned long address)
> > {
> > 	 address = 1;
> >          if (condition()) {
> > 		 while (1) {
> > 			address++;
> > 		 }
> >                 return NULL;
> >         }
> > }
> 
> This works, because there exists a path through the function that has only
> one use of address, ie the path where condition() is false.  It should
> break if you put address = 2; just under address = 1, for example.
> 
Ok, thanks. This fact really is a bit subtle I'd say but hopefully will not
be once I get past the learning curve. Interestingly, if I do the following
then that works too without needing 'exists':

virtual report

@pte_args depends on report@
identifier E1, E2;
type T1, T2;
position p;
@@

 pte_alloc at p(T1 E1, T2 E2)
 {
<+...
 E2
...+>
 }

@script:python depends on report@
p << pte_args.p;
@@
coccilib.report.print_report(p[0], "WARNING: found definition of pte_alloc with
address used in the body")

thanks,

 - Joel
