From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 10 Jun 2018 09:43:37 +0200 (CEST)
Subject: [Cocci] High level restriction of function calls with SmPL
In-Reply-To: <ece57387-d899-55dd-738d-0180d08b7935@users.sourceforge.net>
References: <8f24e468-34d5-7cce-9543-7833fc8e76f7@users.sourceforge.net>
 <alpine.DEB.2.20.1806100838190.2313@hadrien>
 <ece57387-d899-55dd-738d-0180d08b7935@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1806100942590.2313@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 10 Jun 2018, SF Markus Elfring wrote:

> >>      when != action(..., input, ...)
> ?
> >> Now I am looking for ways to restrict (or filter) such function calls further.
> ?
> > "restrict ... further" and "correspond" are not precise.
>
> The ?imprecision? happens because I find SmPL expression possibilities unclear
> once more here.
>
>
> > I have no idea what you want to do.
>
> I guess that we have got a common understanding that something should be
> performed for function calls.
> The input data type is known for a single parameter in a generic way
> (for this SmPL example).
> Now it is interesting if one of its properties like the changeability
> (usage of ?const?) will be acceptable for selected function calls.
> Do you get more ideas for the desired software clarification?

I still have no idea what you want to do.  Please provide an example.  If
you don't know concretely what you want to do, please figure it out and
then ask afterwards.

julia
