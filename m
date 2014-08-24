From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 24 Aug 2014 07:51:43 -0500 (CDT)
Subject: [Cocci] Clarification for dependencies in SmPL rules
In-Reply-To: <53F9DD5D.50807@users.sourceforge.net>
References: <1408772085-28818-1-git-send-email-Julia.Lawall@lip6.fr>
 <53F9DD5D.50807@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1408240751210.2460@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, 24 Aug 2014, SF Markus Elfring wrote:

> > + at depends on patch@
> > +identifier r.i;
> > +type t;
> > +@@
>
> Would the specification "@variable_deletion depends on r@" be useful for such a
> semantic patch rule?

Maybe it would be more efficient.  But conceptually it is redundant.

julia
