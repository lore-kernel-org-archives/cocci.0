From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 2 Oct 2014 15:04:12 +0200 (CEST)
Subject: [Cocci] string parameter concatenation
In-Reply-To: <542D4AA2.6060407@users.sourceforge.net>
References: <20141001130215.GB4701@rei.suse.cz>
 <542D4AA2.6060407@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1410021503420.2101@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 2 Oct 2014, SF Markus Elfring wrote:

> > nit.cocci:
> > @@
> > expression list L;
> > @@
> > - f(L);
> > + g(L);
> 
> Would it make sense and work to write a semantic patch rule like the following?
> 
> @replacement@
> @@
> -f
> +g
> (L);
> 
> 
> Can the passed parameters be omitted from the desired adjustment by "the plus line"?

For the particular example, this would be better, but presumably the real 
case is more complex.

julia
