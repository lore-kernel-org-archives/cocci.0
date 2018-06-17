From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 17 Jun 2018 22:25:59 +0200 (CEST)
Subject: [Cocci] Searching for constants between shift operators with
 SmPL
In-Reply-To: <fb10378d-dccb-73ed-ddf0-e62d1c181794@users.sourceforge.net>
References: <5e128120-0168-397f-e2fb-9ffd59ec3683@users.sourceforge.net>
 <alpine.DEB.2.20.1806171949590.2506@hadrien>
 <ae26a5be-ba96-cf08-c3cb-cced3c04f44d@users.sourceforge.net>
 <alpine.DEB.2.20.1806172038050.2506@hadrien>
 <4179275b-eafb-7622-2f92-06a4b0b1b39e@users.sourceforge.net>
 <alpine.DEB.2.20.1806172108320.2506@hadrien>
 <a2f0f632-d84d-379c-8386-0acbace4eae0@users.sourceforge.net>
 <alpine.DEB.2.20.1806172122100.2506@hadrien>
 <7d9d3e4f-c789-538e-f4eb-beb1462d8ba0@users.sourceforge.net>
 <alpine.DEB.2.20.1806172150150.2506@hadrien>
 <fb10378d-dccb-73ed-ddf0-e62d1c181794@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1806172223270.2506@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 17 Jun 2018, SF Markus Elfring wrote:

> >> I hoped that a semicolon could be interpreted as the closing delimiter
> >> for an assignment statement.
> >
> > No.  That would make the parse amiguous.
>
> I am curious on the clarification of related ambiguity concerns.

...; could match a sequence of statements followed by an empty statement
or a single statement consisting of an expression followed by a ;.  The
parser favors the former.  The former may seem less useful than the
latter, but the constraints of a yacc like parser mean that the former has
to be the one that is chosen.

> > While a ... can match a single expression,
>
> I hoped that the SmPL ellipsis could handle also an optional continuation
> for a computation so that I do not need to express a subsequent operator.

It can't.  This is not going to change.

julia
