From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 8 Jul 2018 09:46:06 +0200 (CEST)
Subject: [Cocci] Applicability of SmPL inheritance?
In-Reply-To: <1ed9edbe-e2aa-dfec-a2c3-fb43274f2c2e@users.sourceforge.net>
References: <1ed9edbe-e2aa-dfec-a2c3-fb43274f2c2e@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1807080945250.2689@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 8 Jul 2018, SF Markus Elfring wrote:

> Hello,
>
> I would like to clarify another combination of functionality from the semantic
> patch language.
> The following small SmPL script can be constructed to find some function calls.
>
> @rtg@
> identifier F, G;
> @@
>  F(..., 9);
> *G(1, ...);
>
> @rth@
> identifier F, H;
> @@
>  F(..., 9);
> *H(2, ...);
>
>
> The important detail is here that both SmPL rules specify to search for
> the same function calls before other source code should be found.
> This common SmPL code could be moved into another SmPL rule.
>
> @rpx@
> identifier F;
> position P;
> @@
>  F(..., 9);@P
>
> @rpg@
> identifier rpx.F, G;
> position rpx.P;
> @@
>  F(..., 9);@P
> *G(1, ...);
>
> @rph@
> identifier rpx.F, H;
> position rpx.P;
> @@
>  F(..., 9);@P
> *H(2, ...);
>
>
> I became curious to know if the shown inherited information could be used also
> without repeating SmPL code for a precondition.
> Can the search be continued directly behind the determined source code position?

 F(..., 9);
(
*G(1, ...);
|
*H(2, ...);
)

should be fine.

julia
