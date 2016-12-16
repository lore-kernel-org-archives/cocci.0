From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 16 Dec 2016 15:33:58 +0100 (CET)
Subject: [Cocci] malloc/calloc/strup adding missing NULL checks
In-Reply-To: <20161216141242.3tisfzykz5zxcdtu@fbsd-laptop>
References: <20161216113410.4vauxw4u2f364l7v@fbsd-laptop>
 <alpine.DEB.2.10.1612161242300.3566@hadrien>
 <20161216131350.5xc6awlrv2yu5xso@fbsd-laptop>
 <alpine.DEB.2.10.1612161453460.6500@hadrien>
 <20161216141242.3tisfzykz5zxcdtu@fbsd-laptop>
Message-ID: <alpine.DEB.2.10.1612161531110.6500@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 16 Dec 2016, Thomas Adam wrote:

> On Fri, Dec 16, 2016 at 02:54:42PM +0100, Julia Lawall wrote:
> > Could you send me the original .c file, preferably cut down to show only
> > the error?
> >
> > For --parse-c, most of the interestingoutput is on stderr.
>
> Hi Julia,
>
> Yes -- stderr was redirected to those files anyway.
>
> Please see the attached .c file which just contains a sample function which
> isn't being matched.

For me, the attached file seems to work fine.  But the function is quite
big and contains many strdups.  If there is one that is not getting
matched, perhaps you could make a smaller example that illustrates the
problem.

>From the type-c output, I have the impression that it is pkg_adddep that
is not getting processed.  That has no type annotations at all.  The other
functions seem to have annotations on some variables.  When Coccinelle
doesn't know the type, it will put /**/.  But that means that it processed
the code but doesn't know the type, not that it did not process the code
at all.

julia
