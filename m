From: thomas.adam22@gmail.com (Thomas Adam)
Date: Fri, 16 Dec 2016 14:46:46 +0000
Subject: [Cocci] malloc/calloc/strup adding missing NULL checks
In-Reply-To: <alpine.DEB.2.10.1612161531110.6500@hadrien>
References: <20161216113410.4vauxw4u2f364l7v@fbsd-laptop>
 <alpine.DEB.2.10.1612161242300.3566@hadrien>
 <20161216131350.5xc6awlrv2yu5xso@fbsd-laptop>
 <alpine.DEB.2.10.1612161453460.6500@hadrien>
 <20161216141242.3tisfzykz5zxcdtu@fbsd-laptop>
 <alpine.DEB.2.10.1612161531110.6500@hadrien>
Message-ID: <20161216144645.h3tl5m3f5333zif2@fbsd-laptop>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Dec 16, 2016 at 03:33:58PM +0100, Julia Lawall wrote:
> For me, the attached file seems to work fine.  But the function is quite
> big and contains many strdups.  If there is one that is not getting
> matched, perhaps you could make a smaller example that illustrates the
> problem.

There's others, but it's the same variation on the theme.

> From the type-c output, I have the impression that it is pkg_adddep that
> is not getting processed.  That has no type annotations at all.  The other
> functions seem to have annotations on some variables.  When Coccinelle
> doesn't know the type, it will put /**/.  But that means that it processed
> the code but doesn't know the type, not that it did not process the code
> at all.

Odd.  I am invoking spatch with -I repeatedly to ensure that it includes the
relevant headers.

What would you suggest I do next to try and understand why pkg_adddep() isn't
being processed?  When I use --debug, I see the entire thing is marked as
"bad:" -- and although there's a hint in there about "set verbose_parsing",
I'm unsure what that means, or whether it would help.

Thanks again for your time and help, Julia.

Thomas
