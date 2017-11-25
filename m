From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 25 Nov 2017 14:32:37 +0100 (CET)
Subject: [Cocci] Question about a not made change
In-Reply-To: <633b583b-7a10-5f20-75f8-53fa51c2e3ec@orange.fr>
References: <d45758b3-f6cb-dc3a-0be2-c0b282aa9be9@orange.fr>
 <alpine.DEB.2.20.1711250843550.2027@hadrien>
 <633b583b-7a10-5f20-75f8-53fa51c2e3ec@orange.fr>
Message-ID: <alpine.DEB.2.20.1711251431290.2096@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sat, 25 Nov 2017, Francois-Xavier Le Bail wrote:

> On 25/11/2017 08:44, Julia Lawall wrote:
> > On Sat, 25 Nov 2017, Francois-Xavier Le Bail wrote:
> >> I try the following patch:
> >> -----
> >> @@
> >> u_char *p;
> >> expression n;
> >> @@
> >> ND_PRINT(
> >> ...,
> >> -p[n]
> >> +EXTRACT_U_1(p + n)
> >>  )
> >> -----
> >> on the following (minimized) code:
> >> -----
> >> int main()
> >> {
> >>         u_char *p;
> >>         ND_PRINT(ndo, ": %02x %02x", p[1], p[2]);
> >>
> >>         return 0;
> >> }
> >> -----
> >> I got:
> >> -----
> >> +++ /tmp/cocci-output-1795-a34831-main.c
> >> @@ -1,7 +1,7 @@
> >>  int main()
> >>  {
> >>         u_char *p;
> >> -       ND_PRINT(ndo, ": %02x %02x", p[1], p[2]);
> >> +       ND_PRINT(ndo, ": %02x %02x", p[1], EXTRACT_U_1(p + 2));
> >>
> >>         return 0;
> >>  }
> >> -----
> >> Why the first p[1] is not change to EXTRACT_U_1(p + 1)?
> >>
> >> Did I miss something obvious?
> >
> > Yes :)  There is no ,... after your change, so you only perform the change
> > when it is the last argument.
>
> Thus, going closer my original problem, where ND_PRINT is a macro which requires double parenthesis,
> I try :
> -----
> @@
> u_char *p;
> expression n;
> @@
> ND_PRINT((
> ...,
> -p[n]
> +EXTRACT_U_1(p + n)
> ,...
>  ))
> -----
> I got:
> -       ND_PRINT((ndo, ": %x %x %x %x", p[1], p[2], p[3], p[4]));
> +       ND_PRINT((ndo, ": %x %x %x %x", p[1], p[2], EXTRACT_U_1(p + 3), p[4]));
> -----
>
> Another thing I miss?

I'mnot sure that the double parens are well supported.  Try <+... ...+>
around your specific change, but I don't know if it will work.

julia


>
> --
> Francois-Xavier
>
