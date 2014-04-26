From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 26 Apr 2014 17:52:47 +0200
Subject: [Cocci] Extract an interface with SmPL
In-Reply-To: <CABxcv=nOLP3mR1jWf_k=ahdQ=5Y-O=CimmKUWACVuAmzGpOsHQ@mail.gmail.com>
References: <CABxcv==X0rP2h2xeD1myS5N=dbNWb8HLJhEyMQ-HK6iU-QFjng@mail.gmail.com>	<alpine.DEB.2.10.1404251821570.3323@hadrien>	<CABxcv==diNNJ+5ZovQb+kmVrWO1v1sc59GeO2nXAs=i2b1gq0Q@mail.gmail.com>	<alpine.DEB.2.02.1404252324460.2176@localhost6.localdomain6>	<CABxcv=mEHrg0=VSRYAtMJq_papbLYQa4Y1y8j+38n7-3=V6SsQ@mail.gmail.com>	<535B6EB3.9070705@users.sourceforge.net>
 <CABxcv=nOLP3mR1jWf_k=ahdQ=5Y-O=CimmKUWACVuAmzGpOsHQ@mail.gmail.com>
Message-ID: <535BD64F.4000700@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Great, I didn't know that this kind of refactoring pattern was named
> ExtractInterface and yes that's exactly what I want to achieve here.

Thanks for your feedback.

It will help to discuss further approaches after the goal is clear with a name
that is well-known for some software designers and developers. I hope that
experiences from other tools can eventually be reused then.


> I'm sure other subsystems will benefit from the same semantic patch if
> is generic enough so makes sense to me to be included to a demo collection.

Coccinelle provides a "small" semantic pattern collection for demonstration
purposes already.
https://github.com/coccinelle/coccinelle/tree/master/demos

Would you like to extend it with approaches for source code refactoring?


> Probably the only change that will have to be made in the spatch is
> the regular expression to filter the function names and the name of
> the two data structures.

I imagine that there are some software development challenges for the
implementation with the semantic patch language.

1. You refer to designated initializers from the standard "ISO/IEC 9899:1999".
   http://thevirtualmachinist.blogspot.de/2012/03/c99-designated-initializers.html

   Do you need to consider the case when they are not used in a source file?

2. You mentioned a few variations already. How difficult or interesting will the
handling of optional elements become?

3. Initialisation and assignment statements can vary in their number and order
generally. How would you like to treat differences here?

4. Do you need to introduce unique names for variables and involved data structures?

Regards,
Markus
