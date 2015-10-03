From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 3 Oct 2015 09:09:22 +0200 (CEST)
Subject: [Cocci] [PATCH v2] coccinelle: assign signed result to unsigned
 variable
In-Reply-To: <1443437687-16559-1-git-send-email-a.hajda@samsung.com>
References: <alpine.DEB.2.10.1509261106040.2737@hadrien>
 <1443437687-16559-1-git-send-email-a.hajda@samsung.com>
Message-ID: <alpine.DEB.2.02.1510030901180.2022@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Some comments:

If you get 20 good results and 22 false positives, I'm not sure whether 
high confidence is justified.  That seemes more like moderate confidence.

On the other hand, I think it is possible to get rid of the false 
positives.  The false positives are coming from the fact that you have:

if ( \( vu < 0 \| vu <= 0 \) ) S1 else S2

This can be flipped around to

if ( ! \( vu < 0 \| vu <= 0 \) ) S2 else S1

and then when we propagate the ! into the disjunction, we get v >= 0 for 
the first condition and v > 0 for the second condition.  v >= 0 is always 
true, so it could be reasonable to highlight it, but v > 0 is a perfectly 
reasonable test for an unsigned value, and is where you are getting the 
false positives from.  If you want to get rid of both v >= 0 and v < 0 
then you can just put disable neg_if in the initial @@, just after r, ie

@r disable neg_if@

On the other hand, if you want to keep the warning on v >= 0 but drop the 
warning on v > 0, then you will have to split the rules and put the 
disable neg_if on the one for v <= 0.

I think it would also be reasonable to merge the proposed semantic 
patches.  I guess this one gives most of the results anyway?

With recursive_includes, I got 70 results,@least 20 of which should be 
false positives due to the MB case.

julia
