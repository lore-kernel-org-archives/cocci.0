From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 18 Jul 2015 21:57:31 +0200 (CEST)
Subject: [Cocci] Finding unstored return values with SmPL
In-Reply-To: <55AA5667.5010009@users.sourceforge.net>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
 <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
 <55AA476F.7020907@users.sourceforge.net>
 <alpine.DEB.2.02.1507181451340.2016@localhost6.localdomain6>
 <55AA5667.5010009@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1507182154010.2086@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I would like to achieve a bit of functionality which is already provided
> by other popular static source code analysis tools

Why not use them then?

> The SmPL approach that we are discussing now should point open issues out
> in source code like the following small test example.
> 
> int implementation_with_an_ignored_return_value(void)
> {
>  malloc(123);
>  return 0;
> }
> 
> 
> I imagine that a complete solution would need a detailed data flow analysis
> for this purpose. But I am not familiar enough will all necessary
> technology there so far.
> 
> So I hope that a smaller solution can be achieved with Coccinelle.
> * I can find an ordinary function call without problems.
> 
> * The corresponding software development challenges become apparent
>   when I would like to ensure by a SmPL filter that the source code position
>   of this call is different from all other function calls which were detected
>   at other places within a function implementation.
> 
>   @show_unstored_return_values
>    depends on !find_calls_for_initialisations
>            && !find_calls_for_designated_initialisations
>            && !find_calls_for_assignments@

I have the impression that you just want

f(...);

once you have determined that f has a return value.  No need for positions
or dependencies on other rules.

On the other hand, this is very liable to false positives when there is
some good reason why the return value of the particular call to f doesn't
matter.

julia
