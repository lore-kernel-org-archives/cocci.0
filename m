From: thomas.adam22@gmail.com (Thomas Adam)
Date: Fri, 16 Dec 2016 19:31:56 +0000
Subject: [Cocci] malloc/calloc/strup adding missing NULL checks
In-Reply-To: <alpine.DEB.2.10.1612162018470.3178@hadrien>
References: <20161216141242.3tisfzykz5zxcdtu@fbsd-laptop>
 <alpine.DEB.2.10.1612161531110.6500@hadrien>
 <20161216144645.h3tl5m3f5333zif2@fbsd-laptop>
 <alpine.DEB.2.10.1612161549220.6500@hadrien>
 <20161216170814.netw7heh2bdyvmm5@fbsd-laptop>
 <alpine.DEB.2.10.1612161929450.3239@hadrien>
 <20161216183705.madw4mpsfqmkvmky@fbsd-laptop>
 <alpine.DEB.2.10.1612162004510.3178@hadrien>
 <20161216191011.cgxsa7mymssrjtsx@fbsd-laptop>
 <alpine.DEB.2.10.1612162018470.3178@hadrien>
Message-ID: <20161216193155.vkgyk2alpxkjve46@fbsd-laptop>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Dec 16, 2016 at 08:21:35PM +0100, Julia Lawall wrote:
> The problem for the vset function is that a pattern like
> 
> A
> ...
> 
> requires that there be no A along all paths leaving from the matched A.
> Your code matching the first pattern is in a loop, so obviously there is
> at least one path that reaches A again.  So the rule doesn't match.  If
> you want to consider the region until A optionally occurs again, then you
> can write:
> 
> A
> ...
> ?A
> 
> The ? makes it optional.

Ah.  I think I understand that, Julia.  If I blindly modify the strdup rule to
this:

	T = strdup(...);
	+ if (T == NULL)
	+ 	pkg_emit_errno("strdup", __func__);
	?... when != (T == NULL)
	?    when != (T != NULL)

And then run:

	spatch --in-place --sp-file ~/unchecked_malloc.cocci libpkg/pkg.c

This now captures the other remaining strdup() calls which were going
undetected.  However, as a side-effect of this, the matching rule is adding in
the same NULL checks for function calls which already has them; hence a
doubling-up.

I appreciate I've just blindly followed your advice; could you perhaps
elaborate (and educate me) as to the correct way to ammend this rule?

Thanks.

Thomas
