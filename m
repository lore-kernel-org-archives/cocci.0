From: kborer@cpan.org (Kris Borer)
Date: Fri, 24 Jul 2015 07:20:11 -0400
Subject: [Cocci] if conditions
In-Reply-To: <alpine.DEB.2.02.1507240752060.2225@localhost6.localdomain6>
References: <CAMy_N60PKB7DYD5-s+pAHRAnpPFqLFGRAquYbP_HOtKCAW4aTQ@mail.gmail.com>
 <alpine.DEB.2.02.1507240752060.2225@localhost6.localdomain6>
Message-ID: <CAMy_N62+N-=WR_KMjBjC9zwLWgX1WXLbsFotnByO4T2bxf5vSA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Okay, thank you anyway :)

On Fri, Jul 24, 2015 at 1:56 AM, Julia Lawall <julia.lawall@lip6.fr> wrote:

> On Thu, 23 Jul 2015, Kris Borer wrote:
>
> > I have a working semantic patch, but was wondering if there was a way to
> > avoid some repetition. I am trying to match a number of if-statements,
> but
> > only care about the first condition of each. Is there a way to match an
> > arbitrary number of additional conditions? I tried using dots and various
> > metavariables without success. Any advice would be appreciated.
>
> It's complicated.  Unfortunately the associativity of && and || goes the
> wrong way:
>
> a && b && c = (a && b) && c not a && (b && c)
>
> To try to help with this problem, Coccinelle provides
>
> a && ...
>
> but that allows a to appear anywhere at toplevel in the chain of &&s,
> which is not what you want.
>
> The only thing I can see to do is to use the a && ... pattern, and then
> use position variables to find the one that is furthest to the left on the
> lowest line.
>
> This would be rather complicated.
>
> julia
>
> > bash> cat conditions.c
> > void main(){
> >     int x = 0;
> >
> >     if ( (x = 0) != 0 ) {
> >         x = 1;
> >     }
> >
> >     if ( (x = 0) != 0 && x < 0 ) {
> >         x = 1;
> >     }
> >
> >     if ( (x = 0) != 0 && x < 0 && x > 1 ) {
> >         x = 1;
> >     }
> > }
> > bash> cat conditions.cocci
> > @k1@
> > identifier i;
> > expression E;
> > statement S, S2;
> > constant c;
> > binary operator b;
> > @@
> >
> > + i = E;
> >   if (
> > - (i = E)
> > + i
> >   b c) S else S2
> >
> > @k2@
> > identifier i;
> > expression E, E2;
> > statement S, S2;
> > constant c;
> > binary operator b, b2;
> > @@
> >
> > + i = E;
> >   if ( (
> > - (i = E)
> > + i
> >   b c) b2 E2) S else S2
> >
> > @k3@
> > identifier i;
> > expression E, E2, E3;
> > statement S, S2;
> > constant c;
> > binary operator b, b2, b3;
> > @@
> >
> > + i = E;
> >   if ( ( (
> > - (i = E)
> > + i
> >   b c) b2 E2) b3 E3) S else S2
> >
> > bash> spatch --sp-file conditions.cocci conditions.c
> > init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> > HANDLING: conditions.c
> > diff =
> > --- conditions.c
> > +++ /tmp/cocci-output-6769-da5e98-conditions.c
> > @@ -1,15 +1,18 @@
> >  void main(){
> >      int x = 0;
> >
> > -    if ( (x = 0) != 0 ) {
> > +    x = 0;
> > +    if (x != 0 ) {
> >          x = 1;
> >      }
> >
> > -    if ( (x = 0) != 0 && x < 0 ) {
> > +    x = 0;
> > +    if (x != 0 && x < 0 ) {
> >          x = 1;
> >      }
> >
> > -    if ( (x = 0) != 0 && x < 0 && x > 1 ) {
> > +    x = 0;
> > +    if (x != 0 && x < 0 && x > 1 ) {
> >          x = 1;
> >      }
> >  }
> >
> > Thank you,
> >
> > Kris
> >
> >
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150724/c09b6658/attachment.html>
