From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 18 May 2018 18:53:39 +0200 (CEST)
Subject: [Cocci] Matching function pointer typedef
In-Reply-To: <51d95102-78ad-b56b-c470-c83d3f6c6b9b@users.sourceforge.net>
References: <alpine.DEB.2.20.1805172125150.2273@hadrien>
 <51d95102-78ad-b56b-c470-c83d3f6c6b9b@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1805181853230.3339@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 18 May 2018, SF Markus Elfring wrote:

> >> I am trying to modify an function pointer typedef something like:
> >>
> >> @@
> >> @@
> >> - typedef void (*toto_t)(int a, int b);
> >> + typedef void (*toto_t)(int a, int b, int c);
> >
> > This now works.
>
> Thanks for another software improvement.
> https://github.com/coccinelle/coccinelle/commit/80dcf751e411f1421fdcdb7119a95e50b841609c
>
>
> > Currently, you need to remove the whole typedef and add it back,
>
> I find this information inappropriate because such a source code replacement
> was attempted.

It was attempted before the change was made.

julia

>
>
> > not just add the third argument as H?kon suggested.
>
> It can be clearer to limit changes precisely while it can be also occasionally nice
> to extend the adjustment a bit so that the affected source code will be
> hopefully reformatted by the Coccinelle software in a desired way.
> https://github.com/coccinelle/coccinelle/issues/37
>
> Regards,
> Markus
>
