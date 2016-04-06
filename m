From: der.herr@hofr.at (Nicholas Mc Guire)
Date: Wed, 6 Apr 2016 06:02:56 +0000
Subject: [Cocci] Insert statement before every return point
In-Reply-To: <alpine.DEB.2.02.1604030728030.2018@localhost6.localdomain6>
References: <20160403063412.GA2982@hird.mnieto.com.ar>
 <alpine.DEB.2.02.1604030728030.2018@localhost6.localdomain6>
Message-ID: <20160406060256.GA18795@osadl.at>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Sun, Apr 03, 2016 at 07:30:16AM +0200, Julia Lawall wrote:
> 
> 
> On Sun, 3 Apr 2016, Diego Nieto Cid wrote:
> 
> > Hello,
> > 
> > I'm new to Coccinelle and there's a patch I wrote that doesn't
> > work as I expected.
> > 
> > The purpose of the patch is to implement a toy stack smashing
> > protector by inserting a local variable with a unique name, by
> > using 'fresh identifier', in every function and checking its
> > value before returning.
> > 
> > The patch is the followig:
> > ----8<----8<----8<----8<----8<----8<----
> > @@
> > identifier fn;
> > fresh identifier canary = "canary_";
> > @@
> >  fn (...)
> >  {
> > +  int canary = 0xdeadbeef;
> >    ...
> > +  if ((canary ^ 0xdeadbeef) != 0)
> > +      DIVIDE_BY_ZERO;
> >   return ...;
> >  }
> 
> I'm not sure why it doesn't work on your example.  However it sems to work 
> better like this:
> 
> @@
> identifier fn;
> fresh identifier canary = "canary_";
> @@
>  fn (...)
>  {
> +  int canary = 0xdeadbeef;
>    <...
> +  if ((canary ^ 0xdeadbeef) != 0)
> +      DIVIDE_BY_ZERO;
>   return ...;
>   ...>
>  }
> 
> This just makes the change whereever it is relevant, regardless of 
> control-flow.  It seems to even work in the case of an implicit return at 
> the end of the function, when the function has a void return type.
>
the canary would need to be declared volatile or gcc will 
optimize it out.

thx!
hofrat
