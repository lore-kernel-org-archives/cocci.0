From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 15 Jul 2015 06:30:36 -0400 (EDT)
Subject: [Cocci] Finding unstored return values with SmPL
In-Reply-To: <55A62135.90206@users.sourceforge.net>
References: <55A62135.90206@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1507150629540.2670@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 15 Jul 2015, SF Markus Elfring wrote:

> Hello,
>
> I can find some function calls with the help of the semantic patch
> language easily.
> But I see further software development challenges in the following use cases.
>
> 1. The return value was not used for the initialisation of a variable.
>
> 2. The return value was not assigned to another variable.
>
>
> Do I need to fiddle with SmPL position variables to determine if an assignment
> is not performed together with a call within a function implementation?
>
> I would appreciate your advices for such a source code analysis.

No idea what you are trying to do.  Write something, and then if the
result is not satisfactory, ask afterwards.

julia
