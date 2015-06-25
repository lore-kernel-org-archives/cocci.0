From: skunk@iSKUNK.ORG (Daniel Richard G.)
Date: Wed, 24 Jun 2015 23:10:05 -0400
Subject: [Cocci] Various minor parsing bugs
In-Reply-To: <alpine.DEB.2.10.1506240934280.2553@hadrien>
References: <1434594839.2823366.298546905.56C27EC5@webmail.messagingengine.com>
 <alpine.DEB.2.10.1506231430140.2554@hadrien>
 <1435098813.2577840.305986601.7F5C26BA@webmail.messagingengine.com>
 <alpine.DEB.2.10.1506240934280.2553@hadrien>
Message-ID: <1435201805.2992101.307114657.0D123073@webmail.messagingengine.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 2015 Jun 24 07:40+0200, Julia Lawall wrote:
> 
> OK, perhaps I was not quite correct.  Overall, it seems to be related to 
> the goal of matching disjunctions on expressions from left to right.  For 
> example, if you have a pattern like:
> 
> (
> - &x
> + y
> |
> - x
> + z
> )
> 
> and the code you have is &x, then you expect to get y.  Maybe it is
> throwing away matches with later terms that overlap with matches for
> earlier ones.  I would have thought that only smaller matches would
> get thrown away, but whenever things overlap there is a danger of
> inconsistent modifications, so maybe any overlap at all is the better
> strategy.

Hmm. I think I may need to find a better example with which to examine
this behavior, one where the disjunction turns out to be necessary
after all. (I'm a bit uneasy with not knowing how overlaps interact
with disjunctions, and I suspect the issue will crop up again in a
different form.)

> > Coccinelle already does some preprocessor handling; there isn't a
> > way to tell it to look at only one side of a particular conditional?
> > The example I gave is a trivial one---the expression could be
> > written out twice---but there are others less amenable to such a
> > rewrite.
>
> There are some special cases where it ignores one side, but in general
> it doesn't.  I think that to make this decision in general you have to
> parse, and the ifdefs block parsing.

Could some ifdefs be selectively evaluated/ignored for parsing purposes?

> Mostly Coccinelle has heuristics for identifying types.  I'll have to 
> check again why they were not triggered in your case.

If it helps, here are the minimal cases I put together where the C99
type flummoxed Coccinelle (when not mentioned in a macro file):

    #include <stdlib.h>
    #include <stdint.h>

    size_t foo1(void *ptr)
    {
        return bar((int32_t)(size_t)ptr);
    }

    void foo2(char *array)
    {
        array[(int32_t)'.'] = '.';
    }


On Wed, 2015 Jun 24 09:36+0200, Julia Lawall wrote:
> For #ifdef, are the terms in the two branches proper expressions
> normally (like in your example)?  Perhaps we could do something for
> that.  Or are there things like
> 
> #ifdef XXX
> 3 +
> #else
> 4 -
> #endif
> 5

Just about, yes. There are idioms like

    int
    #ifdef WIN32
    WINAPI WinMain([...])
    #else
    main(int argc, char *argv[])
    #endif
    {

and others where the conditional/surrounding parts can't stand on their
own. The wisdom of writing code in this way may be questionable, but I
would be happy for Coccinelle to evaluate the conditional itself, and
process only one side. (In my case, the WIN32 side is irrelevant.)


--Daniel


-- 
Daniel Richard G. || skunk at iSKUNK.ORG
My ASCII-art .sig got a bad case of Times New Roman.
