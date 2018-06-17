From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 17 Jun 2018 21:53:32 +0200 (CEST)
Subject: [Cocci] Searching for constants between shift operators with
 SmPL
In-Reply-To: <7d9d3e4f-c789-538e-f4eb-beb1462d8ba0@users.sourceforge.net>
References: <5e128120-0168-397f-e2fb-9ffd59ec3683@users.sourceforge.net>
 <alpine.DEB.2.20.1806171949590.2506@hadrien>
 <ae26a5be-ba96-cf08-c3cb-cced3c04f44d@users.sourceforge.net>
 <alpine.DEB.2.20.1806172038050.2506@hadrien>
 <4179275b-eafb-7622-2f92-06a4b0b1b39e@users.sourceforge.net>
 <alpine.DEB.2.20.1806172108320.2506@hadrien>
 <a2f0f632-d84d-379c-8386-0acbace4eae0@users.sourceforge.net>
 <alpine.DEB.2.20.1806172122100.2506@hadrien>
 <7d9d3e4f-c789-538e-f4eb-beb1462d8ba0@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1806172150150.2506@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 17 Jun 2018, SF Markus Elfring wrote:

> >> Where do you expect that such an empty statement would occur here?
> >
> > Because your rule contained ...;
>
> Yes.
>
>
> > which is a ... followed by an empty statement.
>
> I hoped that a semicolon could be interpreted as the closing delimiter
> for an assignment statement.

No.  That would make the parse amiguous.  While a ... can match a single
expression, to avoid ambiguity, such a ... cannot appear at the beginning
of the expression.  A way around this is to put (...);  That could match
an assignment statement, due to the paren isomorphism.  But that won#t
match return c; because return c is not an expression either.  It's simply
not a complete term.

> > return c; is,
>
> My source code example contained this line.

Yes, but you have to get the ... to match something and the ; to match
something.  If the ; matches the ; at the end of the return, then what
does the ... match?

julia
