From: mcgrof@suse.com (Luis R. Rodriguez)
Date: Mon, 8 Jun 2015 23:44:58 +0200
Subject: [Cocci] Using or for structural #ifdefs
In-Reply-To: <alpine.DEB.2.02.1506082306420.2041@localhost6.localdomain6>
References: <20150608203717.GS23057@wotan.suse.de>
 <alpine.DEB.2.02.1506082306420.2041@localhost6.localdomain6>
Message-ID: <20150608214458.GV23057@wotan.suse.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Mon, Jun 08, 2015 at 11:13:47PM +0200, Julia Lawall wrote:
> On Mon, 8 Jun 2015, Luis R. Rodriguez wrote:
> 
> > 
> > An examle or SmPL patch (from upstream Coccinelle tests/orexp.cocci):
> > 
> > @@                                                                              
> > expression E, F;                                                                
> > @@                                                                              
> >                                                                                 
> > (                                                                               
> > -  foo(E)                                                                       
> > + 4                                                                             
> > |                                                                               
> > -  bar(F)                                                                       
> > + 4                                                                             
> > )  
> > 
> > This works nicely for code within functions, for backporting we at times
> > need to use or clauses for code outside of functions. We can avoid the
> > or statements when backporting but if we could use them it would provide
> > the ability to produce unified diffs which are much more readible and
> > would resemble more what humans would try to write. I'll explain with
> > an example.
> 
> I don't think that or is the problem.  If you have:
> 
> + foo();
> (
> - x();
> + y();
> |
> - m();
> + n();
> )
> + foo2();
> 
> the disjunction will still only match one statement.  Of course, you could 
> put between the calls to foo and foo2 something that would match two 
> statements, and then that would match two statements.  Or something that 
> would match one or two statements.
> 
> The problem for structure field initializations would seem to be that they 
> are unordered.  That is, if you put an initialization for x and then an 
> initialization for y, the C code might have x initialized before y or vice 
> versa, and with arbitrary things between them.  So the #ifdef/#endif would 
> very likely come out in undesirable places.

Doesn't the original developer have the responsibility over the order?
So long as we proceed on the code in order and perform the operations
asked atomically its not clear to me how this would be an issue.

> The problem for functions is that Coccinelle only sees one at a time.  It 
> has no idea whether one function is before or after another, and whether 
> they are contiguous or there is something between them.

Understood, similarly -- it would seem to me fair for Coccinelle to trust
the order already in place and just address disjunctions atomically as
they are found top - down.

I may have misunderstood the issue though.

> Maybe this would be better done with some tool that is separate from 
> Coccinelle.  There could be a danger of modifying #ifdefs that were in the 
> original code.  If that would be a bad thing, then the tool could take the 
> old and new code as inputs, and only eliminate ifdefs that are unique to 
> the new code.

A tool to optimize patches seems like a super useful tool. Grammatically
however I also think it'd be useful to be able to use disjunctions on functions
/ structur declarations. The last item (c) on grouping metavariables would also
be extremey useful as it would shorten the length of the rules and I think also
enable more readible SmPL patches.

 Luis
