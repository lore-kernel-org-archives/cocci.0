From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 21 May 2018 19:03:44 +0200 (CEST)
Subject: [Cocci] Using data from a parameter list with SmPL
In-Reply-To: <80999588-9b47-ce85-7354-2588dcbb228a@users.sourceforge.net>
References: <80999588-9b47-ce85-7354-2588dcbb228a@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1805211902590.2853@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 21 May 2018, SF Markus Elfring wrote:

> Hello,
>
> A specific function can be found also by a selection on its parameter list.
> The semantic patch language provides a metavariable type for this purpose.
>
> I would occasionally like to create another function variant then.
> It should get a shorter parameter list with a few elements from the other list.
> Is it possible to construct something based on the first and second list element
> in a generic way?

I guess that if you want the first three parameters, you could say

parameter list[3] ps;

and then

f(ps,...) { ... }

julia
