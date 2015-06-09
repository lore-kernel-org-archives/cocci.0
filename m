From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Wed, 10 Jun 2015 00:50:35 +0200
Subject: [Cocci] Using or for structural #ifdefs
In-Reply-To: <alpine.DEB.2.02.1506090711320.2069@localhost6.localdomain6>
References: <20150608203717.GS23057@wotan.suse.de>
 <alpine.DEB.2.02.1506082306420.2041@localhost6.localdomain6>
 <20150608214458.GV23057@wotan.suse.de>
 <alpine.DEB.2.02.1506090711320.2069@localhost6.localdomain6>
Message-ID: <20150609225035.GX23057@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jun 09, 2015 at 07:25:11AM +0200, Julia Lawall wrote:
> > Doesn't the original developer have the responsibility over the order?
> > So long as we proceed on the code in order and perform the operations
> > asked atomically its not clear to me how this would be an issue.
> 
> In the case where you add new things, you control the order, and I think
> there is actually no problem.  You just have to check that both things you
> considered adding were actually added.  For example if you have one rule
> that might add an initializer A at the end of a structure, and then another
> rule that might add an initialier B in this position, then you now A is
> before B.  If you now that both rules matched then you can just add an
> #ifdef before A and an #endif after B.  Coccinelle doesn't even care if
> they are added in an unbalanced way, ie one rule could add the #ifdef and
> another could add the #endif.
>
> Similarly for function definitions.

OK one typical backport case we tend to have is multiple, maybe optional,
initializers on the struct and prior to this multiple, depending on the struct
initializers present, function definitions. The ability to ifdef grouped items
then would only work if the entire set of struct initializers were present and
I think contiguous but the hard thing about this lies in that the functions
we would want to #idef out are group'd and optional and go first prior to
the struct initializer.

> There problem comes if you eg just a replace an existing field, rather than
> explicitly adding a new one at the end of the structure.  Or put the new
> variant next to an existing one.

I believe I had used 

struct foo {
	...
+	int a;
};

before to hint to add at the top while using the ... at the end to the bottom,
I typically to add to the top to avoid issues with possible uses in code of
the end variable being used for a flexible array which requires it to be
declared at the end so adding something new at the end would break that
flexible array.

I haven't yet had the need, at leaest for backports, to care where exactly
to add *new* fields.

> Or, in terms of functions, if you add a
> definition after one function and before another one.  In that case,
> Coccinelle doesn't make available any information about the relative
> position of the new things.  You could assume that certain things were
> always defined together in the original code, but it seems risky.

I see, I'd expect the rule writer to be aware of this risk, but do understand
the possible issue that could arise.

> > > The problem for functions is that Coccinelle only sees one at a time.  It 
> > > has no idea whether one function is before or after another, and whether 
> > > they are contiguous or there is something between them.
> > 
> > Understood, similarly -- it would seem to me fair for Coccinelle to trust
> > the order already in place and just address disjunctions atomically as
> > they are found top - down.
> > 
> > I may have misunderstood the issue though.
> > 
> > > Maybe this would be better done with some tool that is separate from 
> > > Coccinelle.  There could be a danger of modifying #ifdefs that were in the 
> > > original code.  If that would be a bad thing, then the tool could take the 
> > > old and new code as inputs, and only eliminate ifdefs that are unique to 
> > > the new code.
> > 
> > A tool to optimize patches seems like a super useful tool. Grammatically
> > however I also think it'd be useful to be able to use disjunctions on functions
> > / structur declarations. The last item (c) on grouping metavariables would also
> > be extremey useful as it would shorten the length of the rules and I think also
> > enable more readible SmPL patches.
> 
> It would certainly be useful to have disjnctions on more kinds of things.
> This is just a development time/priority issue.

Got it.

> I'm not sure to understand the grouping metavariable idea.

The grouping idea would enable the disjuction expressed as you note below
within the rule declaration of metavariables instead of on the rule itself.
That would enable avoiding regexp or escaping disjuctions as below by just
making the associatin of one metavariable to a series of metavariables
delcared under one name.

> People who 
> like regular expressions would just write a regular expression for what 
> you propose.  Since I don't particularly like regular expressions, and 
> since I know that Coccinelle doesn't use them for indexing, I would rather 
> write:
> 
> \(get_dma \| map_dma \| unmap_dma \| attach_dma \| detach_dma\)
> 
> That may not work at the moment in the context in which it is wanted.  But 
> that is just another or problem, not a metavariable problem.

I see, thanks!

  Luis
