From: volanschi@metaware.fr (Nic Volanschi (R&D))
Date: Tue, 30 Jul 2013 16:36:25 +0200
Subject: [Cocci] transforming non-pointer arguments in a call
In-Reply-To: <alpine.DEB.2.02.1307301448370.2336@hadrien>
References: <1375187792.3200.33.camel@zamolxis.metaware.tm.fr>
 <alpine.DEB.2.02.1307301448370.2336@hadrien>
Message-ID: <1375194985.3200.39.camel@zamolxis.metaware.tm.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 2013-07-30 at 14:52 +0200, Julia Lawall wrote:
> It is related to the semantics of ( | ).
> For an expression, the ( | ) is moved up to top level.
I see! Good to know...
I now perfectly understand why it worked like that.

> A solution could be:
> 
> @bad@
> position p;
> idexpression *ptr;
> @@
> ctdli(...,ptr at p,...)
> 
> @@
> position p != bad.p;
> idexpression e;
> @@
> ctdli(...,
> - e at p
> + &e
>   ,...)

Excellent, thanks! Now it works like expected.
Nic.
