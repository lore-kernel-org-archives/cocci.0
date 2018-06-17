From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 17 Jun 2018 21:24:38 +0200 (CEST)
Subject: [Cocci] Searching for constants between shift operators with
 SmPL
In-Reply-To: <a2f0f632-d84d-379c-8386-0acbace4eae0@users.sourceforge.net>
References: <5e128120-0168-397f-e2fb-9ffd59ec3683@users.sourceforge.net>
 <alpine.DEB.2.20.1806171949590.2506@hadrien>
 <ae26a5be-ba96-cf08-c3cb-cced3c04f44d@users.sourceforge.net>
 <alpine.DEB.2.20.1806172038050.2506@hadrien>
 <4179275b-eafb-7622-2f92-06a4b0b1b39e@users.sourceforge.net>
 <alpine.DEB.2.20.1806172108320.2506@hadrien>
 <a2f0f632-d84d-379c-8386-0acbace4eae0@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1806172122100.2506@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 17 Jun 2018, SF Markus Elfring wrote:

> >> Should anything be found in the following source code variant then?
> >>
> >> int main(void)
> >> {
> >> unsigned int a = 2, b = 4;
> >> unsigned long c = a << 2 << b;
> >> return c;
> >> }
> >
> > No, because there is no empty statement to match the final ;.
>
> Where do you expect that such an empty statement would occur here?

Because your rule contained ...; which is a ... followed by an empty
statement.

> > The ... matches a complete statement (in general, 0 or more complete statements).
> > It doesn't match return c
>
> Is this line also a complete statement?

No.  return c is not a complete statement.  return c; is, but then there
is nothing to match the ;

>
> I am struggling still with the presented interpretations if the SmPL ellipsis
> should match an expression or/and statements.

If it is in the middle of an expression, it matches a single expression.
If it is elsewhere it matches a sequence of 0 or more statements.  It can
also match eg a sequence of 0 or more field declarations in a structure
declaration or 0 or more parameters in a function header.

julia
