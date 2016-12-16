From: thomas.adam22@gmail.com (Thomas Adam)
Date: Fri, 16 Dec 2016 21:55:38 +0000
Subject: [Cocci] malloc/calloc/strup adding missing NULL checks
In-Reply-To: <alpine.DEB.2.10.1612162032340.3178@hadrien>
References: <20161216144645.h3tl5m3f5333zif2@fbsd-laptop>
 <alpine.DEB.2.10.1612161549220.6500@hadrien>
 <20161216170814.netw7heh2bdyvmm5@fbsd-laptop>
 <alpine.DEB.2.10.1612161929450.3239@hadrien>
 <20161216183705.madw4mpsfqmkvmky@fbsd-laptop>
 <alpine.DEB.2.10.1612162004510.3178@hadrien>
 <20161216191011.cgxsa7mymssrjtsx@fbsd-laptop>
 <alpine.DEB.2.10.1612162018470.3178@hadrien>
 <20161216193155.vkgyk2alpxkjve46@fbsd-laptop>
 <alpine.DEB.2.10.1612162032340.3178@hadrien>
Message-ID: <20161216215537.p3ymxl3t6526af3i@fbsd-laptop>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Dec 16, 2016 at 08:33:55PM +0100, Julia Lawall wrote:
> > Ah.  I think I understand that, Julia.  If I blindly modify the strdup rule to
> > this:
> >
> > 	T = strdup(...);
> > 	+ if (T == NULL)
> > 	+ 	pkg_emit_errno("strdup", __func__);
> > 	?... when != (T == NULL)
> > 	?    when != (T != NULL)
> 
> The ? doesn't go on the ... line. I'm rather surprised that that would
> parse, even.  Your line in the A position is T = strdup(...);.  So you

spatch certainly didn't mind, and went on to apply the rule.  If I've
uncovered a bug, great!  :)

> need to put another copy of that at the end of the rule with  ? in front
> of it.  So that it stops when it comes to that again.

And now it's working just fine.  Thanks ever so much for all of your help,
Julia, and your continued efforts on Coccinelle; it's a fantastic piece of
software.

Kindly,
Thomas Adam
