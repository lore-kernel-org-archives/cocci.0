From: kborer@cpan.org (Kris Borer)
Date: Tue, 14 Jul 2015 19:28:09 -0400
Subject: [Cocci] binary operator matching on v1.0.1
In-Reply-To: <alpine.DEB.2.10.1507141337000.3373@hadrien>
References: <CAMy_N609w3sYYyn54z4MTzPifpZVSaZ7gDPGPCcxajdbw=hhOA@mail.gmail.com>
 <alpine.DEB.2.10.1507111837110.6791@hadrien>
 <CAMy_N61Ce4jvQnrXMEvPPJrC_9sdJ3nuL3xmU8RyaWpOYoaUdA@mail.gmail.com>
 <alpine.DEB.2.10.1507141337000.3373@hadrien>
Message-ID: <CAMy_N63m5G_ViwC1xjV4hfwLZohwyCmD3pqCWVaA1pT3d5=ieg@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Thank you for your help. Your patches and advice have solved my issue.

On Tue, Jul 14, 2015 at 1:51 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:

> Two patches are attachd that should help with this.  They can be applied
> in any order.
>
> > bash> cat binop4.cocci
> > @@
> > identifier i, i2;
> > expression E1, E2;
> > constant c;
> > binary operator b;
> > @@
> >
> > + if( E1->i ) {
> > +      i2 = E2;
> > +     if (i2 b c) {
> > - if( E1->i && (i2 = E2) b c ) {
> >   ...
> > - }
> > +     }
> > + }
>
> Even with the patches, it is necessary to adjust the above code.  The
> problem is that with a binary operator metavariable, we don't know the
> precedence or associativity of the operator.  However we have the paren
> isomorphism that will drop extra parentheses in the semantic patch
> (without changing th structure of the AST), so you can just add
> parentheses to the semantic patch to get the precedence or associativity
> you want.  I guess you would want ((i2 = E2) b c).
>
> julia
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20150714/a355bc5c/attachment.html>
