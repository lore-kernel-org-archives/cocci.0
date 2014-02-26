From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 26 Feb 2014 10:39:04 +0100 (CET)
Subject: [Cocci] Branch layout for if statements with SmPL disjunctions
In-Reply-To: <530D96EF.7050306@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530D96EF.7050306@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1402261038220.2106@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 26 Feb 2014, SF Markus Elfring wrote:

> >> ( if (input) is
> >> | if (likely(input)) is
> >> )
> >>   else es
> >
> > This is not allowed.  Inside a disjunction you need to have complete terms.
>
> I imagine that it would be nice if parts from an if statement could be
> written in the shown way. Would such an extension be useful for the
> semantic patch language?

No, I think that simple rules are better.  Always use complete terms is a
simple rule.

julia

> I can easily adjust my simple pattern here because each if branch will be
> matched by a metavariable. I hope that the corresponding repetition of bigger
> subpatterns can be avoided in the future.
>
> Regards,
> Markus
>
