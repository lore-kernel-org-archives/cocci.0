From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 15 Jan 2018 10:24:22 +0100 (CET)
Subject: [Cocci] Coccinelle: alloc_cast: Add more memory allocating
 functions to the list
In-Reply-To: <545310fc-d64e-a970-3c76-6dfd15f9a8b3@users.sourceforge.net>
References: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
 <9eb82024-38fe-19d0-2aad-2e19869cf5a2@users.sourceforge.net>
 <alpine.DEB.2.20.1801150736580.2637@hadrien>
 <545310fc-d64e-a970-3c76-6dfd15f9a8b3@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1801151015581.3305@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 15 Jan 2018, SF Markus Elfring wrote:

> >>> + at depends on context && r1@
> >>
> >> Will the use of a position variable be helpful here?
> >
> > No.  There is no need to repeat the same check for each place where a
> > given type occurs.
>
> I imagine that information from a position which was detected by the SmPL
> rule ?r1? should be reused by subsequent SmPL rules.

I don't fully understand the above, but if python code inherits a position
variable, its effect only applies to that position.  If there are three
different positions, but the other inputs are the same, the python code
will still be run three times. There is no need for this in the context or
patch case, because the behavior of the python code does not depend on the
position in any way.

>
>
> > If the type always looks the same, checking it once is sufficient
> > for all uses.
>
> Can it be safer to take specific source places into account precisely
> (by metavariable inheritance)?

There is nothing more or less safe about it.

>
> >>> +  \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
> >>
> >> Did you consider to handle the relevant function names by a metavariable
> >> instead of a SmPL disjunction?
> >
> > If you put the names into the constraints of a metavariable there will be
> > no file filtering based on the function names
>
> Why?
>
> Is this a limitation by the Coccinelle software so far?
>
>
> Can they become more appealing?
>
> * SmPL list constraint
>
> * Advanced regular expression

Constraints can be arbitrarily complicated and don't necessarily fit into
the various filtering options provided (grep, id-utils, glimpse).  Now
that you can put script code into constraints, they can also have side
effects.  Thus, the user needs to be able to understand how often they
will be run.

>
> > and the semantic patch will run more slowly.
>
> How did you determine such software behaviour?

If Coccinelle knows the set of words that must be present in a file for
the rule to match, and if an index has been prepared with glimpse or
id-utils, then no time is spent on irrelevant files.  Parsing an
irrelevant file is surely more expensive than doing nothing with it.  If
no index is available, then Coccinelle will search line by line for the
important words before trying to parse the file.  Reading through each
word of a file once is still likely much cheaper than parsing, which may
perform up to four attempts on each function.  I don't know what is the
exact tradeoff in teh case of this specific rule, because the functions
involved are very common.

julia
