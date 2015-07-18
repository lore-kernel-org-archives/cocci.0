From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 18 Jul 2015 13:52:49 +0200 (CEST)
Subject: [Cocci] Finding unstored return values with SmPL
In-Reply-To: <55AA3B1F.5020807@users.sourceforge.net>
References: <55A62135.90206@users.sourceforge.net>
 <alpine.DEB.2.10.1507150629540.2670@hadrien>
 <55AA3B1F.5020807@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1507181351130.2042@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> @show_unstored_return_values
> depends on !find_calls_for_initialisations
>         && !find_calls_for_designated_initialisations
>         && !find_calls_for_assignments@
> identifier allocation =~ "^(?x)
> (?:
>    ippNewRequest
> |
>    sigaction
> )$";

Do you really need to use a regular expression here?  Why not use a 
disjunction in the pattern?

What does x represent?

> position pos;
> @@
>  void receiver(...)

What is received?  Why is the void type important?

>  {
>   <+...
> * allocation at pos(...)

How is it useful to match just thf function call.  This doesn't show 
anything about whether or not the return value is stored.

julia

>   ...+>
>  }
> 
> 
> But I find that the shown dependencies will be insufficient so far.
> I imagine that I should also specify additional constrains for the function
> calls I am looking for.
> Can extensions be better discussed with such a SmPL stub?
> 
> Regards,
> Markus
> 
