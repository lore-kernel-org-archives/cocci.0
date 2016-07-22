From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Fri, 22 Jul 2016 19:08:39 +0000
Subject: [Cocci] [PATCH RFC] coccinelle: tests: if and else branch
 should probably not be identical
In-Reply-To: <alpine.DEB.2.10.1607221855500.4131@hadrien>
References: <1469178343-29192-1-git-send-email-hofrat@osadl.org>
 <alpine.DEB.2.10.1607221855500.4131@hadrien>
Message-ID: <20160722190839.GA15538@osadl.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Jul 22, 2016 at 06:56:47PM +0200, Julia Lawall wrote:
> > +virtual context
> > +virtual org
> > +virtual report
> > +
> > + at cond@
> > +statement S1;
> > +position p;
> > +@@
> > +
> > +<+...
> > +* if at p (...) S1 else S1
> > +...+>
> 
> You don't need the <+... ...+>.  Just put the if by itself.
>

will drop that then - though those would be needed for the cases that 
do this recursively. Will fix it and resend.

thx!
hofrat
