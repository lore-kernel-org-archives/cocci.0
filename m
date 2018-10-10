From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 10 Oct 2018 10:11:07 +0200 (CEST)
Subject: [Cocci] Dummy rule for simplifying "depends on" clauses?
In-Reply-To: <9e5331dd-ca41-845b-3852-29941fde1652@users.sourceforge.net>
References: <alpine.DEB.2.21.1810100741210.2477@hadrien>
 <9e5331dd-ca41-845b-3852-29941fde1652@users.sourceforge.net>
Message-ID: <alpine.DEB.2.21.1810101010060.2477@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 10 Oct 2018, SF Markus Elfring wrote:

> > @dummy depends on rule1 || rule2 || rule3@
> >
> > I guess that the problem is that you have to give dummy a pattern
> > that will always match.
>
> Can a software extension make sense for the semantic patch language
> so that the specification of an always matching source code search
> pattern can be omitted?
>
> How do you think about an additional key word in the SmPL rule header?

I think that there are enough keywords already.  Perhaps allowing no
pattern could be permitted, but the problem seems rare.

julia
