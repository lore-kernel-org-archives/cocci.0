From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 3 Dec 2016 14:14:21 +0100 (CET)
Subject: [Cocci] Excluding specific assignment combinations with SmPL
In-Reply-To: <1d21bbab-755e-b7e6-9efd-fde3c084096e@users.sourceforge.net>
References: <1d21bbab-755e-b7e6-9efd-fde3c084096e@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1612031412090.2285@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 3 Dec 2016, SF Markus Elfring wrote:

> Hello,
>
> I am experimenting with another source code search pattern. This approach
> pointed a place like the following out for further considerations.
>
> ?
> 	ice->akm = kcalloc(?);
> 	ak = ice->akm;
> ?
>
>
> My evolving SmPL script used also two separate metavariables with the
> type ?expression? so that the value and target should be distinguished
> for assignment statements. Now I would like to exclude cases where the target
> is directly used again for the value specification as in the small example above.
>
> How should be checked with the means of the semantic patch language that
> the same expression is not used in subsequent lines?

Normally, if you want to prevent something, the easiest thing is to match
it first, and then set up the pattern for what you want so that the latter
matches only if the former did not match.  For example, if you want to
match an identifier other than xxx, you can say:

@@
identifier a;
@@

(
xxx
|
* a
)

Or

@bad@
position p;
symbol xxx;
@@

xxx at p

@@
identifier a;
position p != bad.p;
@@

a at p

julia
