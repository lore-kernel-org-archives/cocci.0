From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 18 Jul 2017 17:10:19 +0200 (CEST)
Subject: [Cocci] [PATCH] Coccinelle report script for refcounters
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612B6FF26BE0@IRSMSX102.ger.corp.intel.com>
References: <1500364111-2192-1-git-send-email-elena.reshetova@intel.com>
 <alpine.DEB.2.20.1707181047350.2529@hadrien>
 <2236FBA76BA1254E88B949DDB74E612B6FF26A28@IRSMSX102.ger.corp.intel.com>
 <alpine.DEB.2.20.1707181352270.3408@hadrien>
 <2236FBA76BA1254E88B949DDB74E612B6FF26BE0@IRSMSX102.ger.corp.intel.com>
Message-ID: <alpine.DEB.2.20.1707181708310.2375@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 18 Jul 2017, Reshetova, Elena wrote:

> > On Tue, 18 Jul 2017, Reshetova, Elena wrote:
> >
> > > > On Tue, 18 Jul 2017, Elena Reshetova wrote:
> > > >
> > > > > The below script can be used to detect potential misusage
> > > > > of atomic_t type and API for reference counting purposes.
> > > > > Now when we have a dedicated refcount_t type and API with
> > > > > security protection implemented, people should be using it
> > > > > instead.
> > > > >
> > > > > Currently it still reports many occurences since we are
> > > > > nowhere near the end of our kernel-wide conversion execrise,
> > > > > but hopefully after couple of cycles more, the amount of
> > > > > output would be much more limited.
> > > > >
> > > > > Each script result must be analysed manually before any
> > > > > conversion, since refcount_t might not suit for certain
> > > > > purposes (for example if an object is not always destroyed
> > > > > upon refcounter reaching zero, if increments from zero are
> > > > > allowed in the code etc.)
> > > > >
> > > > > As we go further and get less results in output, we will
> > > > > improve the pattern to detect conversion cases more precisely.
> > > >
> > > > The regexps are the best you can do?
> > >
> > > They are simple and so far they were sufficient for the purpose since
> > > they found pretty much all the cases we are aware about. I was thinking
> > > on working to improve the pattern later on after we merge the bulk of
> > > conversions and I have some cycles free on that front.
> > >
> > > What would you suggest to do instead of regexps?
> >
> > Is there anything about the definitions of these functions that indicates
> > why they are important?
>
> I am not sure I understand the question fully. Do you mean the functions
> used in the rules, such as atomic_dec_and_test() etc.?
> If yes, then for example the combination of atomic_dec_and_test(&(a)->x)
> on a pointer, then followed later by some kind of *free*(a) function (kfree, kmem_cache_free() etc.)
> on that pointer is a quite common indicator that we are dealing with a reference counter since
> they would normally free resources when counter reaches zero.
> Again, it is not a 100% indicator since I have seen weird schemes that for example
> free a resource upon reaching -1, or free it in one case and don't free on another,
> but such cases are more rare.

I just meant that the name of the function is not always reliable.  Maybe
there is some other property of the definition of the function, like being
a wrapper for kfree, that would be more reliable.  But in this case it is
quite possible that there is not.  We can try with the rule as is and see
what happens.

julia


>
> Does this answer your questions?
>
> Best Regards,
> Elena.
>
> >
> > julia
> >
> > >
> > > Best Regards,
> > > Elena.
> > >
> > > >
> > > > julia
> > > >
> > > > >
> > > > > Elena Reshetova (1):
> > > > >   Coccinelle: add atomic_as_refcounter script
> > > > >
> > > > >  scripts/coccinelle/api/atomic_as_refcounter.cocci | 102
> > > > ++++++++++++++++++++++
> > > > >  1 file changed, 102 insertions(+)
> > > > >  create mode 100644 scripts/coccinelle/api/atomic_as_refcounter.cocci
> > > > >
> > > > > --
> > > > > 2.7.4
> > > > >
> > > > >
> > >
>
