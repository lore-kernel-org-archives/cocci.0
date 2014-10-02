From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 2 Oct 2014 15:37:33 +0200 (CEST)
Subject: [Cocci] string parameter concatenation
In-Reply-To: <20141002130716.GA3635@rei.suse.cz>
References: <20141001130215.GB4701@rei.suse.cz>
 <542D4AA2.6060407@users.sourceforge.net> <20141002130716.GA3635@rei.suse.cz>
Message-ID: <alpine.DEB.2.02.1410021536130.2101@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2 Oct 2014, Cyril Hrubis wrote:

> Hi!
> > Would it make sense and work to write a semantic patch rule like the following?
> > 
> > @replacement@
> > @@
> > -f
> > +g
> > (L);
> > 
> > 
> > Can the passed parameters be omitted from the desired adjustment by "the plus line"?
> 
> The whole rule that I'm working with is:
> 
> @@
> expression list L;
> expression C != {TINFO, TPASS};
> @@
> - tst_resm(C, L);
> - tst_exit();
> + tst_brkm(C, NULL, L);
> 
> Which is used to replace two functions with one and shuffles the
> arguments a bit.

It is not actually necessary to remove and add back L.  You could write:

- tst_resm
+ txt_brkm
   (C,
+   NULL,
    L);
- tst_exit();

However, it is useful to have the bug reports.

julia
